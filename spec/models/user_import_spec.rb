require 'rails_helper'

RSpec.describe UserImport, type: :model do
  describe '#import' do
    let(:limit) { 0 }

    before do
    end

    # it 'returns a response from the dummyjson api with all the 100 records', :aggregate_failures do
    #   subject.new(limit: limit).import
    #   expect(UserFetcherJob).to receive(:perform_later).with(limit: 0, skip: 0).once
    # end

    # it 'ensures that the each record id is sequential from 1 to 100' do
    #   expect(user_import.import['users'].pluck('id')).to eq((1..100).to_a)
    # end

    context 'pagination' do
      # let(:limit) { 5 }

      # it 'returns a response from the dummyjson api', :aggregate_failures do
      #   expect(user_import.import['users'].count).to eq(5)
      #   expect(user_import.import['users'].pluck('id')).to eq((11..15).to_a)
      # end
    end
  end
end
