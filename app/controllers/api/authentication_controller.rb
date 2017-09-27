class Api::AuthenticationController < Api::ApplicationController
  skip_before_action :authorize_request, only: :authenticate

  def authenticate
    user = User.find_by(email: auth_params[:email])
    if user && user.valid_password?(auth_params[:password])
      auth_token = JsonWebToken.encode(user_id: user.id)
      json_response(auth_token: auth_token)      
    else
      raise(ExceptionHandler::AuthenticationError, "Login Invalid")
    end
  end

  private

  def auth_params
    params.permit(:email, :password)
  end
end
