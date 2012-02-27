require 'spec_helper'

describe "Comment" do
  let(:user) { Factory(:user) }
  let(:post1) { Factory(:post, :user => user) }
  let(:post2) { Factory(:post, :user => user) }

  10.times do |i|
    let("comment#{i+1}".to_sym) { Factory(:comment, :user => user, :post_id => post2.id) }
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

 

  it "should display all comments in post's view" do
    post2.save; comment1.save; comment2.save; comment3.save; comment4.save; comment5.save; comment6.save; comment7.save; comment8.save; comment9.save; comment10.save
    visit root_path
    click_link post2.title
    within ".comments" do
      within "#comment_10" do
        page.should have_content(comment10.content)
      end
      page.should have_content(comment9.content)
      page.should have_content(comment8.content)
      page.should have_content(comment7.content)
      page.should have_content(comment6.content)
      page.should have_content(comment5.content)
      page.should have_content(comment4.content)
      page.should have_content(comment3.content)
      page.should have_content(comment2.content)
      page.should have_content(comment1.content)
    end
  end
  
  after do
    User.all.each { |u| u.destroy }
    Post.all.each { |p| p.destroy }
  end

  
end
