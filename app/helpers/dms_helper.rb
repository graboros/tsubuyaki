module DmsHelper
  def sendto_usernames(users)
    if users.present?
      users
        .select{|user| user != current_user}
        .map{|user| user.username}
        .join("、")
    end
  end
end
