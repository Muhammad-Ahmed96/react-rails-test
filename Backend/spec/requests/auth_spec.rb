# spec/requests/auth_spec.rb
require 'rails_helper'
require 'swagger_helper'

RSpec.describe 'Authentication', type: :request do
  path '/login' do
    post 'User login' do
      tags 'Auth'
      security []
      consumes 'application/json'
      produces 'application/json'

      parameter name: :credentials, in: :body, schema: {
        type: :object,
        properties: {
          email: { type: :string },
          password: { type: :string }
        },
        required: %w[email password]
      }

      response '200', 'successful login' do
        let!(:user) { create(:user, email: 'test@example.com', password: 'password', name: 'Test', role: :user) }
        let(:credentials) do
          {
            email: user.email,
            password: 'password'
          }
        end

        run_test! do |response|
          json = JSON.parse(response.body)
          expect(json['token']).to be_present
          expect(json['user']['name']).to eq(user.name)
        end
      end

      response '401', 'invalid credentials' do
        let(:credentials) do
          {
            email: 'test@gmail.com',
            password: 'abc123'
          }
        end

        run_test!
      end
    end
  end
end
