module ApplicationHelper
  def me?(user)
    current_user == user
  end
end
