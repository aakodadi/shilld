class ApplicationController < ActionController::API
  def current_user
    token, options = ActionController::HttpAuthentication::Token.token_and_options(request)

    username = options.blank? ? nil : options[:username]
    user = username && User.find_by(username: username)
    if user && user.authenticated?(token)
      @current_user ||= user
    end
  end

  private

    # Confirms a logged-in user.
    def require_auth
      unless current_user
        head :unauthorized
      end
    end
end
