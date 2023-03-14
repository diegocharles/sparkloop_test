require 'rails_helper'

RSpec.describe UserImport, type: :model do
  describe '#import' do
    let(:limit) { 0 }
    let(:skip) { 0 }
    let(:user_import) { UserImport.new(limit: limit, skip: skip) }

    it 'returns a response from the dummyjson api with all the 100 records', :aggregate_failures do
      expect(user_import.import).to be_a(Hash)
      expect(user_import.import['users']).to be_a(Array)
      expect(user_import.import['users'].count).to eq(100)
    end

    it 'ensures that the each record id is sequential from 1 to 100' do
      expect(user_import.import['users'].pluck('id')).to eq((1..100).to_a)
    end

    context 'pagination' do
      let(:limit) { 5 }
      let(:skip) { 10 }

      it 'returns a response from the dummyjson api', :aggregate_failures do
        expect(user_import.import['users'].count).to eq(5)
        expect(user_import.import['users'].pluck('id')).to eq((11..15).to_a)
      end
    end
  end
end
