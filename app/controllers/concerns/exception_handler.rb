module ExceptionHandler
  extend ActiveSupport::Concern
  class ExpiredSignature < StandardError; end
  class VerificationError < StandardError; end
  class MissingToken < StandardError; end
  class InvalidToken < StandardError; end
  
  included do
    rescue_from ExceptionHandler::ExpiredSignature, with: :unauthorized_request
    rescue_from ExceptionHandler::VerificationError, with: :unauthorized_request
    rescue_from ExceptionHandler::MissingToken, with: :unauthorized_request
    rescue_from ExceptionHandler::InvalidToken, with: :unauthorized_request
    rescue_from ActiveRecord::RecordNotFound do |e|
      json_response({message: e.message}, :not_found)
    end
  end
  
  def unauthorized_request(e)
    json_response({message: e.message}, :unauthorized)
  end
end