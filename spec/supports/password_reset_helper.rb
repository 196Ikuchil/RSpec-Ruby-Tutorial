##capybara
def reset_form(email)
  fill_in "email",        with: email
  click_on "Submit"
end