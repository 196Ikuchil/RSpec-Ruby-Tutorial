
def is_logged_in?
  !session[:user_id].nil?
end

def log_in_session_as(user)
  session[:user_id] = user.id
end

def log_in_as(user,remember_me: true)
  post(:create, params:{
    session:{
      email: user.email,
      password: user.password,
      remember_me: remember_me
    }
  })
end

## capybara ## 

def fill_in_login_form(user, option = { invalid: false })
  if option[:invalid]
    fill_in "email",        with: ""
    fill_in "password",     with: ""
  else
    fill_in "email",        with: user.email
    fill_in "password",     with: user.password
  end
end

def login_in_capy(user)
  fill_in_login_form(user)
  click_button "Log in"
end
##