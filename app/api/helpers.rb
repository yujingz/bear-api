module APIHelpers
  def authenticate!
    token = params['token'] || ""
    error!({ "error" => "401 Unauthorized" }, 401) unless User.exists?(token: token)
  end
end
