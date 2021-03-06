require 'spec_helper'

describe "Post" do
  let(:user) { create(:user) }
  let(:second_user) { create(:user) }
  let(:post1) { create(:post, user: user) }
  let(:post2) { create(:post, user: user) }

  before { post1.save }

  it "should allow registered user to add a post" do
  	visit log_in_path
  	fill_in "Email", with: user.email
  	fill_in "Password", with: user.password
  	click_button "Submit"
  	click_link "New"
  	fill_in "Title", with: "My new title"
  	fill_in "Content", with: "Lorem ipsum is the best content"
  	click_button "Submit"
  	page.should have_content("The post has been updated.")
  	page.should have_content("My new title")
  end

  it "should not allow unregistered user to add a post" do
  	visit new_admin_post_path
  	page.should have_content("You are not authorized to view this content")
  end

  it "should not allow anonymous user to manage posts" do
  	visit root_path
  	click_link post1.title
  	page.should have_content("Posted by #{user.username}")
  	page.should_not have_link("Edit")
  	page.should_not have_link("Delete")
  	visit edit_admin_post_path(post1)
  	page.should have_content("You are not authorized to view this content")
  end

  it "should not allow registered user to manage other user's posts" do
  	visit log_in_path
  	fill_in "Email", with: second_user.email
  	fill_in "Password", with: second_user.password
  	click_button "Submit"
    visit root_path
  	click_link post1.title
  	page.should have_content("Posted by #{user.username}")
  	page.should_not have_link("Edit")
  	page.should_not have_link("Delete")
  	visit edit_admin_post_path(post1)
  	page.should have_content("You are not allowed to manage this post")
  end

  it "should allow registered user to manage his posts" do
  	visit log_in_path
  	fill_in "Email", with: user.email
  	fill_in "Password", with: user.password
  	click_button "Submit"
    visit root_path
  	click_link post1.title
  	page.should have_content("Posted by #{user.username}")
  	page.should have_link("Edit")
  	page.should have_link("Delete")
  	visit edit_admin_post_path(post1)
  	page.should have_content "Edit post"
  	fill_in "Title", with: "My new title"
  	click_button "Submit"
  	page.should have_content "My new title"
  end

  it "should list all posts" do
  	post2.save
  	visit root_path
  	page.should have_content(post1.title)
  	page.should have_content(post2.title)
  end

  it "should allow not allow to add a post with missing content" do
    visit log_in_path
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Submit"
    click_link "New"
    fill_in "Title", with: "My new title"
    click_button "Submit"
    page.should have_content("Post could not be save")
  end

  it "should allow not allow to add a post with missing content" do
    post2.save
    visit log_in_path
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Submit"
    visit edit_admin_post_path(post2)
    fill_in "Title", with: "My new title"
    click_button "Submit"
    page.should have_content("My new title")
  end

  it "should allow not allow to update a post with empty title" do
    post2.save
    visit log_in_path
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Submit"
    visit edit_admin_post_path(post2)
    fill_in "Title", with: ""
    click_button "Submit"
    page.should have_content("Post could not be save")
  end

  it "should allow to delete a post" do
    post2.save
    visit log_in_path
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Submit"
    visit post_path(post2)
    click_on 'Delete Post'
    page.should have_content("The post has been deleted.")
  end

  it "should flash a message when delete failed" do
    post2.save
    class Post
      def destroy
        false
      end
    end
    visit log_in_path
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Submit"
    visit post_path(post2)
    click_on 'Delete Post'
    page.should have_content("Post could not be deleted.")
  end

end
