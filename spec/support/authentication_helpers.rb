module AuthenticationHelpers
  def sign_in_as!(user)
    visit '/signin'
    fill_in "Name", with: user.name
    fill_in "Password", with: user.password
    click_button 'Sign in'
    expect(page).to have_content("Signed in successfully.")
  end
end

RSpec.configure do |c|
  c.include AuthenticationHelpers, type: :feature
end
# Includes the module AuthenticationHelpers into all specs in the spec/features directory

module AuthHelpers
  def sign_in(user)
    session[:user_id] = user.id
  end
end

RSpec.configure do |c|
  c.include AuthHelpers, type: :controller
end

def check_permission_box(permission, object)
  check "permissions_#{object.id}_#{permission}"
end
