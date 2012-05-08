class AuthenticationsController < Devise::OmniauthCallbacksController
	
	def vkontakte
		omni_auth
	end
	def facebook
		omni_auth
	end
	def twitter
		omni_auth
	end

private
	def omni_auth
		auth = request.env["omniauth.auth"]
		@authentication = Authentication.where(uid: auth["uid"].to_s, provider: auth["provider"]).first
		if current_user
			@authentication = current_user.authentications.create!(:uid => auth["uid"], :provider => auth["provider"])
			session[:provider] = @authentication.provider
			sign_in_and_redirect(:user, current_user)
		elsif @authentication && !current_user
			user = @authentication.user
			session[:provider] = @authentication.provider
			sign_in_and_redirect(:user, user)
		else
			session[:omniauth] = auth.except("extra")
			redirect_to new_user_registration_path
		end
	end
end
