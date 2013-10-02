require 'spec_helper'

describe Tag do
  let(:tag) { create(:tag) }
  let(:post1) { create(:post, tag_list: "tag1, tag2, tag3") }
  let(:post2) { create(:post, tag_list: "tag1, tag4, #{tag.name}") }

  subject { tag }

  context "database" do
    it { should have_db_column(:name).of_type(:string) }

    it { should have_db_index(:name) }
  end

  context "validations" do
    it { should validate_presence_of(:name) }
    it { should be_valid }
  end

  context "model" do
    it { should respond_to(:name) }
  end

  describe "after save" do
    it "should return valid tag list" do
      post1.tag_list.should eq "tag1, tag2, tag3"
      post1.tags.map { |tag| tag.name }.should eq ["tag1", "tag2", "tag3"]
    end
  end

  describe "when posts have tags" do
    it "should have one or more posts" do
      tag.posts.should eq [post2]
    end
  end

end
