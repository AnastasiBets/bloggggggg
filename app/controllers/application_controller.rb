class ApplicationController < ActionController::Base

	before_action :divise_sign_up_params, if: :devise_controller?
	protect_from_forgery with: :exception

private

	def divise_sign_up_params
		devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute, :nickname, :avatar])
	end

end
