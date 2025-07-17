require 'rails_helper'
require 'swagger_helper'

RSpec.describe 'Projects API', type: :request do
  path '/admin/projects' do
    get 'List all active projects' do
      tags 'Projects'
      security [ bearerAuth: [] ]
      produces 'application/json'

      response '200', 'projects found' do
        let(:user) { create(:user, role: :admin) }
        let(:Authorization) { "Bearer #{JsonWebToken.encode(sub: user.id)}" }

        before do
          create(:project, name: 'Project 1')
          create(:project, name: 'Project 2')
        end

        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data.length).to eq(2)
        end
      end

      response '401', 'unauthorized' do
        let(:Authorization) { nil }
        run_test!
      end
    end
  end

  path '/admin/projects/{id}/assign-project' do
    post 'Assign Project To User' do
      tags 'Assign Project'
      security [ bearerAuth: [] ]
      produces 'application/json'
      consumes 'application/json'

      parameter name: :id, in: :path, type: :string, description: 'Project ID'
      parameter name: :user_id, in: :body, schema: {
        type: :object,
        properties: {
          user_id: { type: :integer }
        },
        required: [ 'user_id' ]
      }

      response '200', 'project assigned' do
        let!(:admin) { create(:user, role: :admin) }
        let!(:user) { create(:user, role: :user) }
        let!(:project) { create(:project) }
        let(:id) { project.id.to_s }
        let(:Authorization) { "Bearer #{JsonWebToken.encode(sub: admin.id)}" }
        let(:user_id) { { user_id: user.id } }

        run_test! do |response|
          expect(response.status).to eq(200)
          expect(user.reload.projects).to include(project)
        end
      end

      response '401', 'unauthorized' do
        let(:id) { 1 }
        let(:user_id) { { user_id: 1 } }
        let(:Authorization) { nil }
        run_test!
      end

      response '404', 'project not found' do
        let!(:admin) { create(:user, role: :admin) }
        let!(:user) { create(:user, role: :user) }
        let(:id) { 999999 }
        let(:Authorization) { "Bearer #{JsonWebToken.encode(sub: admin.id)}" }
        let(:user_id) { { user_id: user.id } }

        run_test!
      end

      response '404', 'user not found' do
        let!(:admin) { create(:user, role: :admin) }
        let!(:project) { create(:project) }
        let(:id) { project.id.to_s }
        let(:Authorization) { "Bearer #{JsonWebToken.encode(sub: admin.id)}" }
        let(:user_id) { { user_id: 999999 } }

        run_test!
      end

      response '404', 'user not found' do
        let!(:admin) { create(:user, role: :admin) }
        let!(:project) { create(:project) }
        let(:id) { project.id.to_s }
        let(:Authorization) { "Bearer #{JsonWebToken.encode(sub: admin.id)}" }
        let(:user_id) { { user_id: nil } }

        run_test!
      end

      response '422', 'unprocessable entity' do
        let!(:admin) { create(:user, role: :admin) }
        let!(:user) { create(:user, role: :user) }
        let!(:project) { create(:project) }
        let(:id) { project.id.to_s }
        let(:Authorization) { "Bearer #{JsonWebToken.encode(sub: admin.id)}" }
        let(:user_id) { { user_id: user.id } }

        before do
          user.projects << project
        end


        run_test! do |response|
          expect(response.status).to eq(422)
          data = JSON.parse(response.body)
          expect(data['msg']).to eq('User already assigned this project')
        end
      end
    end
  end

  path '/admin/projects/{id}/unassign-project' do
    post 'Assign Project To User' do
      tags 'Unassign Project'
      security [ bearerAuth: [] ]
      produces 'application/json'
      consumes 'application/json'

      parameter name: :id, in: :path, type: :string, description: 'Project ID'
      parameter name: :user_id, in: :body, schema: {
        type: :object,
        properties: {
          user_id: { type: :integer }
        },
        required: [ 'user_id' ]
      }

      response '200', 'project unassigned' do
        let!(:admin) { create(:user, role: :admin) }
        let!(:user) { create(:user, role: :user) }
        let!(:project) { create(:project) }
        let(:id) { project.id.to_s }
        let(:Authorization) { "Bearer #{JsonWebToken.encode(sub: admin.id)}" }
        let(:user_id) { { user_id: user.id } }

        before do
          user.projects << project
        end

        run_test! do |response|
          expect(response.status).to eq(200)
          expect(user.reload.projects).to_not include(project)
        end
      end

      response '401', 'unauthorized' do
        let(:id) { 1 }
        let(:user_id) { { user_id: 1 } }
        let(:Authorization) { nil }
        run_test!
      end

      response '404', 'project not found' do
        let!(:admin) { create(:user, role: :admin) }
        let!(:user) { create(:user, role: :user) }
        let(:id) { 999999 }
        let(:Authorization) { "Bearer #{JsonWebToken.encode(sub: admin.id)}" }
        let(:user_id) { { user_id: user.id } }

        run_test!
      end

      response '404', 'user not found' do
        let!(:admin) { create(:user, role: :admin) }
        let!(:project) { create(:project) }
        let(:id) { project.id.to_s }
        let(:Authorization) { "Bearer #{JsonWebToken.encode(sub: admin.id)}" }
        let(:user_id) { { user_id: 999999 } }

        run_test!
      end

      response '404', 'user not found' do
        let!(:admin) { create(:user, role: :admin) }
        let!(:project) { create(:project) }
        let(:id) { project.id.to_s }
        let(:Authorization) { "Bearer #{JsonWebToken.encode(sub: admin.id)}" }
        let(:user_id) { { user_id: nil } }

        run_test!
      end

      response '422', 'unprocessable entity' do
        let!(:admin) { create(:user, role: :admin) }
        let!(:user) { create(:user, role: :user) }
        let!(:project) { create(:project) }
        let(:id) { project.id.to_s }
        let(:Authorization) { "Bearer #{JsonWebToken.encode(sub: admin.id)}" }
        let(:user_id) { { user_id: user.id } }

        before do
          user.projects.delete(project)
        end


        run_test! do |response|
          expect(response.status).to eq(422)
          data = JSON.parse(response.body)
          expect(data['msg']).to eq('User already unassigned from this project')
        end
      end
    end
  end
end
