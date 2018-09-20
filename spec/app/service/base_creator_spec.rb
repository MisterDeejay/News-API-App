require 'spec_helper'

describe BaseCreator do
  describe "#run" do
    it_behaves_like 'a record creator', 'News' do
      let(:creator) { BaseCreator.new('News', { title: 'News', body: "body" }) }
      let(:invalid_creator) { BaseCreator.new('News',{ title: 'News' }) }
    end
  end
end
