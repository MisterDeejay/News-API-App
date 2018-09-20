require 'spec_helper'

shared_examples_for 'a record creator' do |klass_name|
  context "given correct input for a class" do
    it "returns true" do
      expect(creator.run).to be_truthy
    end

    it "can access the newly created object" do
      creator.run
      expect(creator.record.is_a?(klass_name.constantize)).to be_truthy
    end
  end

  context "given invalid input" do
    it "adds errors to errors array" do
      expect(invalid_creator.errors.empty?).to be_truthy
      invalid_creator.run
      expect(invalid_creator.errors.empty?).to be_falsey
    end
  end
end
