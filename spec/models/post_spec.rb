require 'spec_helper'

describe Post do

  before do
    @user = User.new(username: "Example User", email: "user@example.com", 
            password: "foobar", password_confirmation: "foobar")

    @post = Post.new(user_id: @user_id, :title => "Example post", :content => "Example content")
  end

  subject { @post }

  it { should respond_to(:title) }
  it { should respond_to(:content) }
  it { should respond_to(:tag_list) }
  it { should respond_to(:tags) }
  it {should respond_to (:comments)}

  it { should be_valid }

  describe "when title is not present" do
    before { @post.title = " " }
    it { should_not be_valid }
  end
  
  describe "when content is not present" do
    before { @post.content = " " }
    it { should_not be_valid }
  end

  describe "when content is too short" do
    before { @post.content = "a" }
    it { should_not be_valid }
  end 

  describe Post do
    before do
      @user = Factory.create(:user)
      @post = Factory.create(:post, :user =>@user, :title => "What a wonderful world", :tag_list => "tag1, tag2, tag3")
    end

    context "after save" do
      it "should have pretty permalink" do
        @post.to_param.should == "#{@post.id}-what-a-wonderful-world"
      end

      it "should return valid tag list" do
        @post.tag_list.should eq "tag1, tag2, tag3"
        @post.tags.map { |tag| tag.name }.should eq ["tag1", "tag2", "tag3"]
      end
    end

    context "with comments" do
      it "should have them :)" do
        comment1 = Factory.create(:comment, :user=>@user, :post=>@post)
        comment2 = Factory.create(:comment, :user=>@user, :post=>@post)
        @post.reload.comments.should eq([comment1, comment2])
      end
    end


    after do
      User.all.each { |u| u.destroy }
      Post.all.each { |p| p.destroy }
      Tag.all.each { |t| t.destroy }
    end
  end
end