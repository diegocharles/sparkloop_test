require 'rails_helper'

describe UserApiHandler do
  let(:limit) { 0 }
  let(:skip) { 0 }
  let(:user_attributes) { { name: 'John Doe', age: '44', email: 'john@doe.com' } }

  subject { described_class.new(limit: limit, skip: skip) }

  describe '#fetch_and_create_users' do
    it 'creates a user for each user in the response' do
      VCR.use_cassette('user_api_handler') do
        subject.fetch_and_create_users
        expect(User.count).to eq(100)
      end
    end
  end
end
