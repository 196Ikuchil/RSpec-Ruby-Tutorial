
def is_logged_in?
  !session[:user_id].nil?
end

def has_login_cookie?
  !cookies.signed[:user_id].nil?
end

def has_remember_token_cookie?
  !cookies[:remember_token].nil?
end

def fill_in_login_form(user, option = { invalid: false })
  if option[:invalid]
    fill_in "Email",        with: ""
    fill_in "Password",     with: ""
  else
    fill_in "Email",        with: user.email
    fill_in "Password",     with: user.password
  end
end