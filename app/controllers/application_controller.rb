class ApplicationController < ActionController::API
  before_action :set_user

  # Set global variable user
  def set_user
    begin
      token = AUTHENTICATION_SERVICE.decode_token(request.headers["Authorization"].split(" ")[1])[0]
      # logger.info token
      if !token.nil? && token["exp"] > Time.now.to_i && token["id"].is_a?(Integer)
        @type = token["type"]
        @user = @type == 'student' ? Student.find(token["id"]) : Driver.find(token["id"])
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

  def get_user_token user, type
    if !user.nil? && AUTHENTICATION_SERVICE.get_password(user["password"]) == params[:password]
      return {token: "Bearer #{AUTHENTICATION_SERVICE.create_token(user[:id], 86400, type)}"}
    else
      return USER_NOT_FOUND
    end
  end

  def is_student
    unless @type == 'student'
      render status: 401, json: USER_PERMISSIONS
    end
  end
end
