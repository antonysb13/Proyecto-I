class RegistrationsController < Devise::RegistrationsController

  def new
    super
  end

  #Override the create function
  def create
    build_resource(registration_params)

    #Find the email entered by the guest in the User table in the database 
    @userTemp = User.where(email: resource.email).first
    
    #If user doesn't exist
    if @userTemp.nil?

    	#Save it in the database
	    if resource.save
	      set_flash_message :notice, :signed_up
	      sign_up(resource_name, resource)
	      respond_with resource, :location => after_sign_up_path_for(resource)
	    else
	      #clean_up_passwords
	      respond_with resource
	    end
	else
		#If user already exists, go to registration url and show an error message
		redirect_to new_user_registration_url, :flash => { :error => "Email already registered! Please Sign Up using another email!" }
	end

  end

  def update
  	super
  end

  private

	  def registration_params
	    params.require(:user).permit(:email, :name, :phone, :password, :password_confirmation)
	  end

end 