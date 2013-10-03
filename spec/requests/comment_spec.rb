require 'spec_helper'

describe "Comment" do
  let(:user) { create(:user) }
  let(:post1) { create(:post, user: user) }

  10.times do |i|
    let("comment#{i+1}".to_sym) { create(:comment, user: user, post: post1) }
  end

  before { post1.save }

  it "should allow registered user to add a comment" do
  	visit log_in_path
  	fill_in "Email", :with => user.email
  	fill_in "Password", :with => user.password
  	click_button "Submit"
    visit root_path
  	click_link post1.title
  	fill_in "Content", :with => "Lorem ipsum is the best content"
  	click_button "Submit"
  	page.should have_content("The comment has been added.")
    within("#comment_1") do
  	 page.should have_content("Lorem ipsum is the best content")
    end
  end

  it "should not allow to add a comment without content" do
    visit log_in_path
    fill_in "Email", :with => user.email
    fill_in "Password", :with => user.password
    click_button "Submit"
    visit root_path
    click_link post1.title
    click_button "Submit"
    page.should have_content("Content can't be blank")
  end

  it "should allow anonymous user to add a comment" do
    visit root_path
    click_link post1.title
    fill_in "User email", :with => "my@email.com"
    fill_in "Username", :with => "anonymous"
    fill_in "Content", :with => "Lorem ipsum is the best content"
    click_button "Submit"
    page.should have_content("The comment has been added.")
    within("#comment_1") do
      page.should have_content("anonymous")
     page.should have_content("Lorem ipsum is the best content")
    end
  end

  it "should not allow anonoymous user to add a comment without valid email address" do
    visit root_path
    click_link post1.title
    fill_in "Content", :with => "Lorem ipsum is the best content"
    click_button "Submit"
    page.should have_content("User email can't be blank")
    page.should have_content("Username can't be blank")
  end

  it "should allow user to add a comment in a seprate view" do
    visit new_post_comment_path(post1)
    fill_in "User email", :with => "my@email.com"
    fill_in "Username", :with => "anonymous"
    fill_in "Content", :with => "Lorem ipsum is the best content"
    click_button "Submit"
    page.should have_content("The comment has been added.")
    within("#comment_1") do
      page.should have_content("anonymous")
     page.should have_content("Lorem ipsum is the best content")
    end
  end

end
