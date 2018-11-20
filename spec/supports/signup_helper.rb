def signup(user)
  fill_in "name" ,        with: user.name
  fill_in "email",        with: user.email
  fill_in "password",     with: user.password
  fill_in "password_confirmation", with:user.password
  click_on "Create my account"
end