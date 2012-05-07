class RegistrationsController < Devise::RegistrationsController
	def create
		super
		unless @user.new_record?
			@user.authentications << @authentication
			session[:provider] = @authentication.provider
		else
			session[:omniauth] = nil
		end
	end
	def build_resource(*args)
		super
		if session[:omniauth]
			@user.create_with_session(session[:omniauth])
			@authentication = @user.authentications.build(:uid => session[:omniauth]["uid"].to_s, :provider => session[:omniauth]["provider"])
			@user.valid?
		end
	end
end
