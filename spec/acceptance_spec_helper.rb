def login(user)
  #visit '/'
  visit '/restaurants' # For placeholder index! Use above upon release
  fill_in 'user_login', :with => user.username
  fill_in 'user_password', :with => user.password
  click_button 'Log in'
end