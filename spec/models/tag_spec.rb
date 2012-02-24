require 'spec_helper'

describe Tag do
  before do
    @user = User.create(username: "Example User", email: "user@example.com", 
    				password: "foobar", password_confirmation: "foobar")

    @post = Post.create(user_id: @user_id, :title => "Example post", :content => "Example content")
    @tag = Tag.new(:name => "tag1")
  end

  subject { @tag }

  it { should respond_to(:name) }
  it { should be_valid }

  describe Tag do
    before do
      @user = Factory.create(:user)
      @post1 = Factory.create(:post, :user =>@user, :title => "What a wonderful world", :tag_list => "tag1, tag2, tag3")
      @post2 = Factory.create(:post, :user =>@user, :title => "What a wonderful world", :tag_list => "tag1, tag4")
    end

    context "after save" do
      it "should have pretty permalink" do
        Tag.where(:name => 'tag3').first.to_param.should == "tag3"
      end

      it "should return valid tag list" do
        @post1.tag_list.should eq "tag1, tag2, tag3"
        @post1.tags.map { |tag| tag.name }.should eq ["tag1", "tag2", "tag3"]
      end
    end

    context "when posts have tags" do
      it "should have one or more posts" do
        Tag.where(:name=>"tag1").first.posts.should eq [@post2, @post1]
        Tag.where(:name=>"tag2").first.posts.should eq [@post1]
        Tag.where(:name=>"tag4").first.posts.should eq [@post2]
      end
    end
    after do
      User.all.each { |u| u.destroy }
      Post.all.each { |p| p.destroy }
      Tag.all.each { |t| t.destroy }
    end
  end
end
