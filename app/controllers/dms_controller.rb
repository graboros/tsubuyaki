class DmsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_users, only: %i(create)
  before_action :set_dm, :redirect_when_dm_is_not_mine, only: %i(show)

  layout 'dms_layout'

  def index
  end

  def show
  end

  def new
  end

  def create
    dm = Dm.find_or_initialize_by_users(current_user, @users)
    dm_message = dm.dm_messages.build(message_params)
    dm_message.user = current_user

    if dm.save
      redirect_to dm, notice: "メッセージを追加しました"
    else
      redirect_to new_dm_url, alert: "メッセージの追加に失敗しました"
    end
  end

  def search_user
    @user = User.find_by(username: params[:search_text])
  end
private
  def set_users
    @users = User.where(id: params[:user_ids]).order(:id)
  end

  def set_dm
    @dm = Dm.find(params[:id])
  end
end
