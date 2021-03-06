class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def eesoc
    @user = User.find_for_imperial_oauth(request.env['omniauth.auth'], current_user)

    if @user.persisted?
      sign_in_and_redirect @user, :event => :authentication
      set_flash_message(:notice, :success, :kind => 'EESoc') if is_navigational_format?
    else
      session['devise.eesoc_data'] = request.env['omniauth.auth']
      redirect_to new_user_registration_url
    end
  end
end