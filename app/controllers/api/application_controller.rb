class Api::ApplicationController < ActionController::API
  include ExceptionHandler
  
  before_action :authorize_request
  attr_reader :current_user
  
  def json_response(object, status = :ok)
    render json: object, status: status
  end
  
  private
  def authorize_request
    @current_user ||= User.find(decoded_auth_token[:user_id])
  rescue ActiveRecord::RecordNotFound => e
    raise ExceptionHandler::InvalidToken, "Invalid Token"
  end
  
  def decoded_auth_token
    @decoded_auth_token ||= JsonWebToken.decode(http_auth_reader)
  end
  
  def http_auth_reader
    if request.headers['Authorization'].present?
      return request.headers['Authorization'].strip
    else
      raise ExceptionHandler::MissingToken, "Token Missing"
    end
  end
end