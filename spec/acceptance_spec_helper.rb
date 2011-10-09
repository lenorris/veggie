def login(username, password)
  visit '/'
  fill_in 'user_login', :with => username
  fill_in 'user_password', :with => password
  click_button 'Log in'
end