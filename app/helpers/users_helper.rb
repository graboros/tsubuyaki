module UsersHelper
  def user_show_path?
    request.path_info == user_path(current_user)
  end
  def user_followings_path?
    request.path_info == user_followings_path(current_user)
  end
  def user_followers_path?
    request.path_info == user_followers_path(current_user)
  end
  def user_likes_path?
    request.path_info == user_likes_path(current_user)
  end
end
