require 'rails_helper'

RSpec.describe User, type: :model do
  let!(:user) { create(:user, first_name: 'Joe', email: 'joe@example.com') }

  describe 'validations' do
    it { should validate_presence_of(:last_name) }
    it { should validate_presence_of(:email) }
  end

  describe 'associations' do
    it { should have_one(:bank).dependent(:destroy) }
    it { should have_one(:company).dependent(:destroy) }
    it { should have_one(:address).dependent(:destroy) }
  end

  describe 'ransackable attributes' do
    it 'returns the correct attributes' do
      expect(described_class.ransackable_attributes).to eq(%w[first_name last_name email gender age])
    end
  end

  describe "#destroy" do
    it "sends a deletion notice" do
      expect(UserMailer).to receive(:deletion_notice).with("Joe", "joe@example.com").and_return(double(deliver_later: true))
      user.destroy
    end

    it "broadcasts a removal message" do
      expect(user).to receive(:broadcast_remove_to).with("users")
      user.destroy
    end

    it "ensures that the user is destroyed" do
      user.destroy
      expect(User.find_by(id: user.id)).to be_nil
    end
  end
end
