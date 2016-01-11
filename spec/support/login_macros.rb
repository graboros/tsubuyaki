module LoginMacros

  include Warden::Test::Helpers
  Warden.test_mode!

  def as_user(user, &block)
    current_user = user || create(:user1)
    login_as(current_user, :scope => :user)
    block.call if block.present?
    return self
  end
end
