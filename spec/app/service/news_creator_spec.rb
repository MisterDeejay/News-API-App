require 'spec_helper'

describe NewsCreator do
  describe "#run" do
    it_behaves_like 'a record creator', 'News' do
      let(:creator) { NewsCreator.new(title: 'title', body: 'body') }
      let(:invalid_creator) { NewsCreator.new(title: 'title') }

      context "with params that already exist" do
        let(:params) { {title: "title2", body: "body2" } }
        let!(:article) { News.create(params) }
        let(:creator) { NewsCreator.new(params) }

        it "returns the existing record" do
          creator.run
          expect(creator.record).to eq(article)
        end
      end
    end
  end
end
