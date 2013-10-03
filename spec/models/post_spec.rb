require 'spec_helper'

describe Post do
  let(:user) { create(:user) }
  let(:post) { create(:post) }

  subject { post }

  context "database" do
    it { should have_db_column(:title).of_type(:string) }
    it { should have_db_column(:content).of_type(:text) }
    it { should have_db_column(:user_id).of_type(:integer) }
    it { should have_db_column(:created_at).of_type(:datetime) }
    it { should have_db_column(:updated_at).of_type(:datetime) }

    it { should have_db_index(:title) }
  end

  context "validations" do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:content) }
    it { should be_valid }
  end

  context "model" do
    it { should respond_to(:title) }
    it { should respond_to(:content) }
    it { should respond_to(:tag_list) }
    it { should respond_to(:tags) }
    it {should respond_to (:comments)}
  end

  describe "when title is not present" do
    before { post.title = " " }
    it { should_not be_valid }
  end

  describe "when content is not present" do
    before { post.content = " " }
    it { should_not be_valid }
  end

  describe "when content is too short" do
    before { post.content = "a" }
    it { should_not be_valid }
  end

  describe Post do
    let(:post) { create(:post, user: user, title: "What a wonderful world", tag_list: "tag1, tag2, tag3") }

    context "after save" do
      it "should have pretty permalink" do
        post.to_param.should == "#{post.id}-what-a-wonderful-world"
      end

      it "should return valid tag list" do
        post.tag_list.should eq "tag1, tag2, tag3"
        post.tags.map { |tag| tag.name }.should eq ["tag1", "tag2", "tag3"]
      end
    end

    context "with comments" do
      it "should have them :)" do
        comment1 = create(:comment, user: user, post: post)
        comment2 = create(:comment, user: user, post: post)
        post.reload.comments.should eq [comment1, comment2]
      end
    end
  end
end
