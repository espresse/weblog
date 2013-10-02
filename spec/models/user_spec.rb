require 'spec_helper'

describe User do
  let(:user) { create(:user) }

  subject { user }

  context "database" do
    it { should have_db_column(:email).of_type(:string) }
    it { should have_db_column(:password_hash).of_type(:string) }
    it { should have_db_column(:password_salt).of_type(:string) }
    it { should have_db_column(:username).of_type(:string) }
    it { should have_db_column(:posts_count).of_type(:integer) }
    it { should have_db_column(:created_at).of_type(:datetime) }
    it { should have_db_column(:updated_at).of_type(:datetime) }

    it { should have_db_index(:email) }
    it { should have_db_index(:username) }
  end

  context "validations" do
    describe "on create" do
      let(:user) { build(:user) }
      it { should validate_presence_of(:password) }
    end
    describe "on update" do
      it { should_not validate_presence_of(:password) }
    end
    it { user.should validate_presence_of(:email) }
    it { should validate_presence_of(:username) }
    it { should be_valid }
  end

  context "model" do
    it { should respond_to(:username) }
    it { should respond_to(:email) }
    it { should respond_to(:password_hash) }
    it { should respond_to(:password_salt) }
    it { should respond_to(:password) }
    it { should respond_to(:password_confirmation) }
  end

  describe "when username is not present" do
    before { user.username = " " }
    it { should_not be_valid }
  end

  describe "when email is not present" do
    before { user.email = " " }
    it { should_not be_valid }
  end

  describe "when password is not present" do
    let(:user) { build(:user, password: "", password_confirmation: "a") }

    it { should_not be_valid }
  end

  describe "when username is too long" do
    before { user.username = "a" * 26 }
    it { should_not be_valid }
  end

  describe "when email format is invalid" do
    invalid_addresses =  %w[user@example,com user_at_example.com example.user@example. user]
    invalid_addresses.each do |invalid_address|
      before { user.email = invalid_address }
      it { should_not be_valid }
    end
  end

  describe "when email format is valid" do
    valid_addresses = %w[user@example.com USER@mail.example.com user.name@example.pl user+name@example.co.uk]
    valid_addresses.each do |valid_address|
      before { user.email = valid_address }
      it { should be_valid }
    end
  end

  describe "when email address is already taken" do
    let(:user_with_same_email) { build(:user, email: user.email) }

    it { user_with_same_email.should_not be_valid }
  end

  describe "when password doesn't match confirmation" do
    before { user.password_confirmation = "mismatch" }
    it { should_not be_valid }
  end

  describe "with a password that's too short" do
    let(:user) { build(:user, password: "a"*5, password_confirmation: "a"*5) }

    it { should be_invalid }
  end

  describe "return value of authenticate method" do
    before { user.save }

    describe "with valid password" do
      it { should == User.authenticate(user.email, user.password) }
    end

    describe "with invalid password" do
      let(:user_for_invalid_password) { User.authenticate("invalid", "invalid_password") }
      specify { user_for_invalid_password.should be_false }
    end
  end

end
