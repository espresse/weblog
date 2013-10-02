require 'spec_helper'

describe Comment do
  let(:user) { create(:user) }
  let(:post) { create(:post) }
  let(:comment) { create(:comment) }

  subject { comment }

  context "database" do
    it { should have_db_column(:content).of_type(:text) }
    it { should have_db_column(:user_id).of_type(:integer) }
    it { should have_db_column(:post_id).of_type(:integer) }
    it { should have_db_column(:username).of_type(:string) }
    it { should have_db_column(:user_email).of_type(:string) }
    it { should have_db_column(:created_at).of_type(:datetime) }
    it { should have_db_column(:updated_at).of_type(:datetime) }

    it { should have_db_index([:id, :post_id]) }
    it { should have_db_index(:user_id)}
  end

  context "validations" do
    describe "for anonymous user" do
      let(:comment) { create(:comment, username: "ABC", user_email: "example@example.pl", user_id: nil) }
      it { should validate_presence_of(:username) }
      it { should validate_presence_of(:user_email) }
    end
    describe "for non-anonymous user" do
      it { should_not validate_presence_of(:username) }
      it { should_not validate_presence_of(:user_email) }
    end
    it { should validate_presence_of(:content) }
    it { should be_valid }
  end

  context "model" do
    it { should respond_to(:username) }
    it { should respond_to(:user_email) }
    it { should respond_to(:content) }
  end

  describe "when content is not present" do
    before { comment.content = " " }
    it { should_not be_valid }
  end

  describe "when content is too short" do
    before { comment.content = "a" }
    it { should_not be_valid }
  end

  describe "when username is not present" do
    let(:comment) { build(:comment, username: " ", user_id: nil, user_email: "example@example.com") }
  	it { should_not be_valid }
  end

  describe "when user_email is not present" do
  	let(:comment) { build(:comment, username: "ABC", user_id: nil, user_email: " ") }
  	it { should_not be_valid }
  end

  describe "when user_email format is invalid" do
    invalid_addresses =  %w[user@example,com user_at_example.com example.user@example. user]
    invalid_addresses.each do |invalid_address|
      let(:comment) { build(:comment, username: "ABC", user_id: nil, user_email: invalid_address)}
      it { should_not be_valid }
    end
  end

  describe "when user is present" do
    let(:comment) { create(:comment, username: " ", user_email: " ") }
  	it { should be_valid }
  end
end
