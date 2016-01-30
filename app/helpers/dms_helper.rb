module DmsHelper
  def sendto_usernames(users)
    if users.present?
      users
        .select{|user| user != current_user}
        .map{|user| user.username}
        .join("、")
    end
  end

  def search_user(search_text)
    if search_text.present?
      User.where(username: search_text).where.not(id: current_user.id)
    else
      User.none
    end
  end

end
