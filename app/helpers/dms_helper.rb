module DmsHelper
  def sendto_usernames(users)
    if users.present?
      users
        .select{|user| user != current_user}
        .map{|user| user.username}
        .join("、")
    end
  end

  def get_searched_and_selected_user(search_text, user_array)
    if search_text.present?
      searched = User.where(username: search_text).where.not(id: current_user.id)
    end

    if user_array.present?
      searched = searched.select{|user| user_array.exclude?(user.id.to_s)}
      selected = User.where(id: user_array)
    end

    return searched, selected
  end

end
