class Users::RegistrationsController < Devise::RegistrationsController
# before_filter :configure_sign_up_params, only: [:create]
# before_filter :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
   def new
     super
   end

  # POST /resource
   def create
     @user = User.new(user_params)
     if @user.save
      p "USER SAVED LOGIN: #{@user.username}"
      @cart = Cart.create(:user_id => @user.id, :cart_count => 0)
      @cart.save
      @user.cart_id = @cart.id
      @user.save

      @slot = Slot.create(:cart_id => @cart.id)
      @slot.save
      @cart.slot_id = @slot.id
      @cart.save
      debugger
      if @user.picture == nil
        @user.picture = User.first.picture
      end

      redirect_to root_path
     else
      p "USER FAILED LOGIN: #{@user.username}"
      render 'new'
     end
   end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  private

  def user_params
    params.require(:user).permit( :email, :password, :password_confirmation, :username, :picture )
  end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.for(:sign_up) << :attribute
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.for(:account_update) << :attribute
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
