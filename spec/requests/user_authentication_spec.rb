require 'spec_helper'

describe "UserAuthentication" do
  let(:user) { create(:user) }

  it "should allow user to register" do
  	visit sign_up_path
  	fill_in "Email", :with => "myhero@example.com"
  	fill_in "Username", :with => "MyHero"
  	fill_in "Password", :with => "thePassword"
  	fill_in "Password confirmation", :with => "thePassword"
  	click_button "Submit"
  	page.should have_content("Signed up!")
  end

  it "should not allow user to register with invalid email" do
  	visit sign_up_path
  	fill_in "Email", :with => "myhero"
  	fill_in "Username", :with => "MyHero"
  	fill_in "Password", :with => "thePassword"
  	fill_in "Password confirmation", :with => "thePassword"
  	click_button "Submit"
  	page.should have_content("Email is invalid")
  end

  it "should not allow user to register with empty email and username" do
  	visit sign_up_path
  	fill_in "Password", :with => "thePassword"
  	fill_in "Password confirmation", :with => "thePassword"
  	click_button "Submit"
  	page.should have_content("Email can't be blank")
  	page.should have_content("Username can't be blank")
  end

  it "should not allow user to register with invalid password" do
  	visit sign_up_path
  	fill_in "Email", :with => "myhero@example.com"
  	fill_in "Username", :with => "MyHero"
  	fill_in "Password", :with => "t"
  	fill_in "Password confirmation", :with => "t"
  	click_button "Submit"
  	page.should have_content("Password is too short (minimum is 6 characters)")
  end

  it "should not allow user to register with invalid password confirmation" do
  	visit sign_up_path
  	fill_in "Email", :with => "myhero@example.com"
  	fill_in "Username", :with => "MyHero"
  	fill_in "Password", :with => "thePassword"
  	fill_in "Password confirmation", :with => "theP4ssword"
  	click_button "Submit"
  	page.should have_content("Password doesn't match confirmation")
  end

  it "should not allow user to register with existing email" do
  	visit sign_up_path
  	fill_in "Email", :with => user.email
  	fill_in "Username", :with => "MyHero"
  	fill_in "Password", :with => "thePassword"
  	fill_in "Password confirmation", :with => "thePassword"
  	click_button "Submit"
  	page.should have_content("Email has already been taken")
  end

  it "should allow user to log in" do
    visit log_in_path
    fill_in "Email", :with => user.email
    fill_in "Password", :with => user.password
    click_button "Submit"
    page.should have_content("Logged in!")
  end

  it "should allow user to log out" do
    visit log_in_path
    fill_in "Email", :with => user.email
    fill_in "Password", :with => user.password
    click_button "Submit"
    page.should have_content("Logged in!")
    visit log_out_path
    page.should have_content("Logged out!")
  end

end
