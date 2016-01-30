class DmMessagesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_dm, :redirect_when_dm_is_not_mine, only: %i(create)

  layout 'dms_layout'

  def create
    @dm_message = @dm.dm_messages.build(message_params)
    @dm_message.user = current_user

    unless @dm_message.save
      render js: 'addAlert("メッセージの追加に失敗しました");'
    end
  end
private
  def set_dm
    @dm = Dm.find(params[:dm_id])
  end
end
