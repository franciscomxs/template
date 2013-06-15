class Auth::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  after_filter :store_location

  def all
    if user.persisted?
      sign_in_and_redirect user, event: :authentication
      set_flash_message(:notice, :success, kind: "Facebook") if is_navigational_format?
    else
      session["devise.facebook_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end

  alias_method :facebook, :all

  private
  def user
    User.find_for_facebook_oauth(request.env["omniauth.auth"], current_user)
  end

  def after_sign_in_path_for(resource)
    session[:previous_url] || root_path
  end

  def store_location
    session[:previous_url] = request.fullpath unless request.fullpath =~ /\/users/
  end
end