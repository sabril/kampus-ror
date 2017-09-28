class Api::AuthenticationController < Api::ApplicationController
  skip_before_action :authorize_request, only: [:authenticate]
  
  def authenticate
    @user = User.find_by(email: auth_params[:email])
    if @user && @user.valid_password?(auth_params[:password])
      json_response(auth_token: JsonWebToken.encode(user_id: @user.id))
    else
      raise ExceptionHandler::InvalidToken, "Invalid Credentials"
    end
  end
  
  private
  def auth_params
    params.permit(:email, :password)
  end
end