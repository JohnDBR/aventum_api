class ApplicationController < ActionController::API
  before_action :set_user

  def set_user
    begin
      token = AUTHENTICATION_SERVICE.decode_token(request.headers["Authorization"].split(" ")[1])[0]
      if !token.nil? && token["exp"] > Time.now.to_i && token["id"].is_a?(Integer)
        @user = User.find(token["id"])
      else
        raise "USER_NOT_FOUND"
      end
    rescue Exception => e
      render status: 401, json: USER_NOT_FOUND    
    end
  end

  def upload_profile_picture
    unless params[:profile_picture].blank?
      file_name = "#{SecureRandom.uuid}#{Time.now.to_time.to_i}.png"
      file = S3_BUCKET.object(file_name)
      if(file.upload_file(ImageService::generate_profile_picture(params[:profile_picture].tempfile), { acl: 'public-read' }))
        return file
      else
        render json: INVALID_PROFILE_PICTURE
      end
    else
      render json: INVALID_PROFILE_PICTURE
    end
  end

  def is_student
    unless @user["role"] == "student"
      render json: {err: 'Student not found', code: "007"}
    end
  end

  def is_admin
    unless @user["role"] == "admin"
      render json: {err: 'Admin not found', code: "007"}
    end
  end
end
