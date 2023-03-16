require 'rails_helper'

describe UserFetcherJob do
  describe '#perform' do
    let(:limit) { 5 }
    let(:skip) { 10 }

    subject(:perform) { described_class.perform_now(limit: limit, skip: skip) }

    it 'calls the api handler' do
      expect(UserApiHandler).to receive(:new).with(limit: limit, skip: skip).and_call_original
      expect_any_instance_of(UserApiHandler).to receive(:fetch_and_create_users)
      perform
    end

    context 'when an error is raised' do
      before do
        allow_any_instance_of(UserApiHandler).to receive(:fetch_and_create_users).and_raise(StandardError)
      end

      it 'logs the error' do
        expect(Rails.logger).to receive(:error)
        perform
      end
    end
  end
end
