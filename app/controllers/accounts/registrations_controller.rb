class Accounts::RegistrationsController < Devise::RegistrationsController

  before_action :configure_sign_up_params, only: [:create]
  before_action :configure_account_update_params, only: [:update]

  protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :name, :profile_privacy])
  end
  # If you have extra params to permit, append them to the sanitizer.
  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [:email, :name, :profile_privacy])
  end
  # The path used after sign up for inactive accounts.
  def after_inactive_sign_up_path_for(resource)
    confirmation_pending_path
  end
end
