module UsersHelper
  def user_show_path?
    current_page?(user_path(@user))
  end
  def user_followings_path?
    current_page?(user_followings_path(@user))
  end
  def user_followers_path?
    current_page?(user_followers_path(@user))
  end
  def user_likes_path?
    current_page?(user_likes_path(@user))
  end
end
