class ApplicationController < ActionController::Base
  before_action :check_account_active
  def check_account_active
    unless current_account.active?
      redirect_to root_path, alert: 'Your account is inactive.'
    end
  end
end
