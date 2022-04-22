require 'rails_helper'

describe 'Test user login feature', type: :feature do
  context 'Wrong or absent sign in credentials' do
    before :each do
      User.new(name: 'Mike', photo: 'img', bio: 'I am mike', posts_counter: 0,
               email: 'mike@gmail.com', password: '123456', password_confirmation: '123456')
      visit new_user_session_path
    end

    it 'should return invalid email or password' do
      fill_in 'Email', with: ''
      fill_in 'Password', with: ''
      click_button 'Log in'
      expect(page).to have_text('Invalid Email or password.')
    end

    it 'should return invalid invalid email or password' do
      fill_in 'Email', with: 'ab@gmail.com'
      fill_in 'Password', with: '123456'
      click_button 'Log in'
      expect(page).to have_text('Invalid Email or password.')
    end
  end

  context 'Correct sign in credentials' do
    before :each do
      visit new_user_session_path
      User.create(name: 'Mike', photo: 'img', bio: 'I am Mike', posts_counter: 0,
                  email: 'mike@gmail.com', password: '123456', password_confirmation: '123456')
    end

    it ' should redirects user to index page when login is sucessfull' do
      within 'form' do
        fill_in 'Email', with: 'mike@gmail.com'
        fill_in 'Password', with: '123456'
      end
      click_button 'Log in'
      expect(page).to have_current_path(root_path)
    end
  end
end
