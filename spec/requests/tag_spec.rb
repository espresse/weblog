require 'spec_helper'

describe "Tag" do
  let(:user) { Factory(:user) }
  let(:post1) { Factory(:post, :user => user, :tag_list => "lorem, ipsum, dolor") }
  let(:post2) { Factory(:post, :user => user, :tag_list => "lorem, dolor, ipsum, color") }

  before { post1.save }

  it "should allow registered user to add tags" do 
  	visit log_in_path
  	fill_in "Email", :with => user.email
  	fill_in "Password", :with => user.password
  	click_button "Submit"
  	click_link post1.title
    click_link 'Edit Post'
  	fill_in "Tag list", :with => "oh no!, second"
  	click_button "Submit"
  	page.should have_content("The post has been updated.")
  	page.should have_content("oh no!")
    page.should have_content("second")
    page.should_not have_content("lorem, ipsum, dolor")
  end

  it "should not allow unregistered user to add tags" do 
    visit root_path
  	click_link post1.title
    page.should_not have_content('Edit Post')
    visit edit_post_path(post1)
  	page.should have_content("You are not authorized to view this content")
  end

  
  it "should allow to search for a tag" do
    post2.save
  	visit root_path
    fill_in "search-text", :with => "lorem"
    click_button "GO"
    page.should have_content post1.title
    page.should have_content post2.title

    fill_in "search-text", :with => "dolor"
    click_button "GO"
    page.should have_content post1.title
    page.should have_content post2.title

    fill_in "search-text", :with => "color"
    click_button "GO"
    page.should have_content post2.title
  end

end
