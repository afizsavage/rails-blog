require 'rails_helper'
RSpec.describe 'post_index_route', type: :feature do
  describe 'Post' do
    before(:each) do
      User.create(name: 'mike', photo: 'https://placekitten.com/200/200', bio: 'bio', posts_counter: 0,
                  email: 'mike@gmail.com', password: '123456', password_confirmation: '123456')
      visit new_user_session_path
      fill_in 'Email', with: 'mike@gmail.com'
      fill_in 'Password', with: '123456'
      click_button 'Log in'
      Post.create(title: 'First Post', text: 'This is the first post', comments_counter: 0, likes_counter: 0,
                  author: User.first)
      Post.create(title: 'Second Post', text: 'This is the second post', comments_counter: 0, likes_counter: 0,
                  author: User.first)
      Post.create(title: 'Third Post', text: 'This is the third post', comments_counter: 0, likes_counter: 0,
                  author: User.first)
      Comment.create(text: 'The link is here', author: User.first, post: Post.first)
      Comment.create(text: 'What is this', author: User.first, post: Post.first)
      Comment.create(text: 'Bond be bond', author: User.first, post: Post.first)
      visit(user_posts_path(User.first.id))
    end
    it 'Check for user profile picture' do
      all('img').each do |i|
        expect(i[:src]).to eq('https://placekitten.com/200/200')
      end
    end
    it 'should display username' do
      expect(page).to have_content('mike')
    end
    it 'should display Title' do
      expect(page).to have_content('This is the first post')
    end
    it 'should desplay the post text' do
      post = Post.all
      expect(post.size).to eql(3)
    end
    it 'should Post #1st number in counter' do
      first_user = User.first
      expect(page).to have_content(first_user.posts_counter)
    end
    it 'should display content of the post' do
      expect(page).to have_content 'This is the first post'
    end
    it 'should display first comment' do
      expect(page).to have_content 'The link is here'
    end
    it 'should display number of comments.' do
      post = Post.first
      expect(page).to have_content(post.comments_counter)
    end
    it 'should display number of likes' do
      post = Post.first
      expect(page).to have_content(post.likes_counter)
    end
    it 'should redirects after click' do
      post = Post.first
      click_link 'Post #1'
      expect(page).to have_current_path user_post_path(post.author_id, post.id)
    end
  end
end
