require "rails_helper"

RSpec.describe UserMailer, type: :mailer do
  describe "deletion_notice" do
    let(:mail) { UserMailer.deletion_notice("John", "john@banana.com") }

    it "renders the headers" do
      expect(mail.subject).to eq("Your account has been deleted")
      expect(mail.to).to eq(["john@banana.com"])
    end

    it "renders the body", :aggregate_failures do
      expect(mail.body.encoded).to match("Hello John")
      expect(mail.body.encoded).to match("Your account has been removed")
    end
  end
end
