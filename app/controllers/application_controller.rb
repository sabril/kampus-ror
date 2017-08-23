class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  rescue_from CanCan::AccessDenied do
    redirect_to root_path, alert: "Access Denied"
  end

  def self.render_with_signed_in_user(user, request, *args)
    ActionController::Renderer::RACK_KEY_TRANSLATION['warden'] ||= 'warden'
    proxy = ::Warden::Proxy.new(request.env, ::Warden::Manager.new(Rails.application))
    renderer = self.renderer.new('warden' => proxy)
    renderer.render(*args)
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :address, :email, :password])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :address, :email, :password])
  end
end
