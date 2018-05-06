class StudentsController < ApplicationController
  skip_before_action :set_user, only: [:login, :create, :reset_password, :update_password]

  # POST /login
  def login
    render json: get_user_token(Student.find_by_email(student_login_params[:email]), 'student')
  end

  # GET /students
  def show
    render json: @user
  end

  # POST /reset_password
  # def reset_password
  #   if student.where(:email=> reset_pass_params[:email]).count == 1
  #     ResetPasswordMailer.send_email(student.find_by_email(reset_pass_params[:email]), AUTHENTICATION_SERVICE.create_token("TOKEN_#{student_login_params[:email]}", 3600)).deliver_now!
  #     render json: EMAIL_SENT
  #   else
  #     render json: student_NOT_FOUND
  #   end
  # end

  # PUT /reset_password
  # def update_password
  #   @user = student.find_by_email AUTHENTICATION_SERVICE.decode_token(request.headers["Authorization"])[0]["id"].split("_")[1]
  #   update
  # end

  # POST /students
  def create
    @user = Student.new(student_params.merge(profile_picture: upload_profile_picture.public_url))
    if @user.save
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /students
  def update
    unless params[:profile_picture].blank?
      save_update student_params.merge(profile_picture: upload_profile_picture.public_url)
    else
      save_update student_params
    end
  end
  
  def save_update params
    if @user.update(params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /students
  def destroy
    @user.destroy
    render json: STUDENT_DELETED
  end

  private
    def student_params
      params.permit(:first_name, :last_name, :cc, :email, :phone, :password, :location, :profile_picture).merge(location: 'test')
    end

    def student_login_params
      params.permit(:email, :password)
    end

    # def reset_pass_params
    #   params.permit(:email)
    # end
end
