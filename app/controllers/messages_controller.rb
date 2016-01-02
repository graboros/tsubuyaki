class MessagesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: %i(:index)

  def index
  end

  def dmusers
    @users = current_user.hasMessagesFrom
  end
end
