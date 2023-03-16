describe UserImporter do
  subject { UserImporter.new(limit: 10) }

  describe "#initialize" do
    it "sets @limit to its argument" do
      expect(subject.limit).to eq 10
    end
  end

  describe "#import" do
    before { allow(UserFetcherJob).to receive(:perform_later) }

    it "calls UserFetcherJob.perform_later with the correct parameters" do
      subject.import
      expect(UserFetcherJob).to have_received(:perform_later).with(limit: 10, skip: 0)
    end

    context "when limit is 0" do
      subject { described_class.new(limit: 0) }

      it "calls UserFetcherJob.perform_later once" do
        subject.import
        expect(UserFetcherJob).to have_received(:perform_later).exactly(1).times
      end
    end

    context "when limit is 10" do
      subject { described_class.new(limit: 10) }

      it "calls UserFetcherJob.perform_later 10 times" do
        subject.import
        expect(UserFetcherJob).to have_received(:perform_later).exactly(10).times
      end
    end
  end

  describe "#total_pages" do
    context "when limit is 0" do
      subject { described_class.new(limit: 0) }

      it "returns 1" do
        expect(subject.send(:total_pages)).to eq 1
      end
    end

    context "when limit is 10" do
      subject { described_class.new(limit: 10) }

      it "returns 10" do
        expect(subject.send(:total_pages)).to eq 10
      end
    end
  end

  describe "#skip" do
    context "when page_number is 0" do
      it "returns 0" do
        expect(subject.send(:skip, 0)).to eq 0
      end
    end

    context "when page_number is 2" do
      it "returns 20" do
        expect(subject.send(:skip, 2)).to eq 20
      end
    end
  end
end
