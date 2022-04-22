require 'rails_helper'

describe 'user index page', type: :feature do
  context 'accessing user index page' do
    before :each do
      visit new_user_session_path
      User.create(name: 'Mike', photo: 'https://bit.ly/3LSqRtb', bio: 'I am mike',
                  posts_counter: 0, email: 'abc@gmail.com', password: '123456', password_confirmation: '123456')
      within 'form' do
        fill_in 'Email', with: 'abc@gmail.com'
        fill_in 'Password', with: '123456'
      end
      click_button 'Log in'
    end

    it 'should show the user index page' do
      expect(page).to have_current_path(root_path)
    end

    it 'should show the image of the user' do
      all('img').each do |i|
        expect(i[:src]).to eq('https://placekitten.com/200/200')
      end
    end

    it 'should have 0 posts' do
      expect(page).to have_content('Number of posts: 0')
    end

    it 'should redirect to user show page' do
      click_link 'Mike'
      expect(page).to have_content('I am mike')
    end
  end
end
