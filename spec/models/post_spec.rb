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
end