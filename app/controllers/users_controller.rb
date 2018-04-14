class UsersController < ApplicationController
  skip_before_action :set_user, only: [:login, :create, :reset_password, :update_password]

  # POST /login
  def login
    render json: get_user_token(User.find_by_email(user_login_params[:email]))
  end

  # GET /users
  def show
    render json: @user
  end

  # POST /reset_password
  # def reset_password
  #   if user.where(:email=> reset_pass_params[:email]).count == 1
  #     ResetPasswordMailer.send_email(user.find_by_email(reset_pass_params[:email]), AUTHENTICATION_SERVICE.create_token("TOKEN_#{user_login_params[:email]}", 3600)).deliver_now!
  #     render json: EMAIL_SENT
  #   else
  #     render json: user_NOT_FOUND
  #   end
  # end

  # PUT /reset_password
  # def update_password
  #   @user = user.find_by_email AUTHENTICATION_SERVICE.decode_token(request.headers["Authorization"])[0]["id"].split("_")[1]
  #   update
  # end

  # POST /users
  def create
    @user = User.new(user_params.merge(profile_picture: upload_profile_picture.public_url))
    if @user.save
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users
  def update
    unless params[:profile_picture].blank?
      save_update user_params.merge(profile_picture: upload_profile_picture.public_url)
    else
      save_update user_params
    end
  end
  
  def save_update params
    if @user.update(params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users
  def destroy
    @user.destroy
    render json: USER_DELETED
  end

  private
    def get_user_token user
      if !user.nil? && AUTHENTICATION_SERVICE.get_password(user["password"]) == params[:password]
        return {token: "Bearer #{AUTHENTICATION_SERVICE.create_token(user[:id], 86400)}"}
      else
        return USER_NOT_FOUND
      end
    end

    def user_params
      params.permit(:first_name, :last_name, :cc, :email, :phone, :password, :location, :profile_picture)
    end

    def user_login_params
      params.permit(:email, :password)
    end

    # def reset_pass_params
    #   params.permit(:email)
    # end
end
