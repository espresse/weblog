require 'spec_helper'

describe Comment do
  before do
    @user = User.create(username: "Example User", email: "user@example.com", 
    				password: "foobar", password_confirmation: "foobar")

    @post = Post.create(user_id: @user_id, :title => "Example post", :content => "Example content")

    @comment = Comment.new(:content => "This is a content.", :username => "User", :user_email => "email@example.com")
  end

  subject { @comment }

  it { should respond_to(:username) }
  it { should respond_to(:user_email) }
  it { should respond_to(:content) }

  it { should be_valid }

  describe "when content is not present" do
    before { @comment.content = " " }
    it { should_not be_valid }
  end

  describe "when content is too short" do
    before { @comment.content = "a" }
    it { should_not be_valid }
  end

  describe "when username is not present" do
  	before { @comment.username = " " }
  	it { should_not be_valid }
  end

  describe "when user_email is not present" do
  	before { @comment.user_email = " " }
  	it { should_not be_valid }
  end

  describe "when user_email format is invalid" do
    invalid_addresses =  %w[user@example,com user_at_example.com example.user@example. user]
    invalid_addresses.each do |invalid_address|
      before { @comment.user_email = invalid_address }
      it { should_not be_valid }
    end
  end

  describe "when user is present" do
  	before do
  		@comment.user = @user
  		@comment.username = " "
  		@comment.user_email = " "
  	end
  	it { should be_valid }
  end
end
