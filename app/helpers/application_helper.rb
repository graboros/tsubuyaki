module ApplicationHelper
  def user_show_path?
    request.path_info == user_path(current_user)
  end
  def user_followings_path?
    request.path_info == user_followings_path(current_user)
  end
  def user_followers_path?
    request.path_info == followers_user_path(current_user)
  end
end
