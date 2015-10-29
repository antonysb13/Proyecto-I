class CallbacksController < Devise::OmniauthCallbacksController

    def facebook
	    @user = User.from_omniauth(request.env["omniauth.auth"])
		#If user is null because the email was already registered
		if @user.nil?
			redirect_to new_user_registration_url, :flash => { :error => "Email already registered! Please Sign Up using another email!" }
		else
			#If user is correct
			if @user.persisted?
				sign_in_and_redirect @user
			else
				redirect_to new_user_registration_url
			end
		end
	end
end