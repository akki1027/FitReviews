class ApplicationController < ActionController::Base
	before_action :authenticate_user!, except: [:top, :fr_top, :about, :search, :ranking]
	before_action :configure_permitted_parameters, if: :devise_controller?
	protected
	def configure_permitted_parameters
		devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email])
	end
	# 会員登録後に移動するviewの指定
	def after_sign_up_path_for(resource)
    	fr_top_path
    end

    # ログイン後に移動するviewの指定
    def after_sign_in_path_for(resource)
    	fr_top_path
    end
	# ログアウト後に移動するviewの指定
    def after_sign_out_path_for(resource)
    	fr_top_path
    end
end
