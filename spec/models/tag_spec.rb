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

end
