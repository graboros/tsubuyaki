class DmsController < ApplicationController
  before_action :authenticate_user!

  def index
    @dms = current_user.dmusers.map{|dmuser| dmuser.dm}
  end

  def show
  end
end
