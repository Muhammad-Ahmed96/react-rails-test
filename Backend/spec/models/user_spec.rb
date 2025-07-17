require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'checking validations' do
    subject { build(:user) }

    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email) }

    it { should validate_presence_of(:role) }
  end

  describe 'secure password' do
    it 'check valid password' do
      user = User.create!(email: 'test@example.com', password: 'password', role: :user)
      expect(user.authenticate('password')).to eq(user)
    end

    it 'check invalid password' do
      user = User.create!(email: 'test@example.com', password: 'password', role: :user)
      expect(user.authenticate('abc123')).to eq(false)
    end
  end

  describe '.search scope' do
    before do
      @user1 = create(:user, name: 'User 1', role: :user)
      @user2 = create(:user, name: 'User 2', role: :user)
      @admin = create(:user, name: 'Admin', role: :admin)
      @other = create(:user, name: 'Test', role: :user)
    end

    it 'returns matching users' do
      results = User.search('User')
      expect(results).to include(@user1, @user2)
      expect(results).not_to include(@admin, @other)
    end

    it 'limits the results to 5' do
      6.times { |n| create(:user, name: "User #{n}", role: :user) }
      results = User.search('User')
      expect(results.count).to eq(5)
    end
  end
end
