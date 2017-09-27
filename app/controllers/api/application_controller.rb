class Api::ApplicationController < ActionController::API
	include ExceptionHandler

	before_action :authorize_request
  attr_reader :current_user

	protected
  def json_response(object, status = :ok)
    render json: object, status: status
  end

  def routing_error
		json_response({message: "Not Found"}, :not_found)
	end

	def action_missing(m, *args, &block)
		json_response({message: "Not Found"}, :not_found)
	end

	private
	def authorize_request
		@current_user ||= User.find(decoded_auth_token[:user_id]) if decoded_auth_token
    # handle user not found
  	rescue ActiveRecord::RecordNotFound => e
    # raise custom error
    raise ExceptionHandler::InvalidToken, "Invalid Token"
	end

	# decode authentication token
  def decoded_auth_token
    @decoded_auth_token = JsonWebToken.decode(http_auth_header)
  end

  # check for token in `Authorization` header
  def http_auth_header
    if request.headers['Authorization'].present?
      return request.headers['Authorization'].strip
    else
      raise ExceptionHandler::MissingToken, "Token Missing"
    end
  end
end
