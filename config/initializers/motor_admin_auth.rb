# Extend Motor Admin's ApplicationController to add role-based authentication
Rails.application.config.to_prepare do
  Motor::ApplicationController.class_eval do
    before_action :authorize_motor!

    private

    def authorize_motor!
      current_user = User.find(session[:user_id]) if session[:user_id]
      unless current_user&.role == "admin"
        head :forbidden
      end
    end
  end
end
