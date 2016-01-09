class DmsController < ApplicationController
  before_action :authenticate_user!
  before_action :redirect_when_users_not_selected, :set_users_from_session, only: %i(new create)
  before_action :set_dm, only: %i(show add_message)

  layout 'dms_layout'

  def index
    @dms = current_user.dms
  end

  def select_users
  end

  def submit_users
    @userarray = params[:user]

    if params[:searchbtn].present? 
      @search_text = params[:search_text]

    elsif params[:nextbtn].present?
      @userarray.try(:delete, current_user.id)

      if @userarray.present?
        @userarray.uniq!
        session[:message_to] = @userarray
        render js: "window.location = '#{new_dm_url}'";
      else
        render js: 'alert("メッセージ送付先を選択してください");';
      end
    end
  end

  def show
  end

  def new
  end

  def add_message
    msg = @dm.dmmessages.build(content: message_params[:content], user: current_user)

    if msg.save
      redirect_to @dm, notice: "メッセージを追加しました"
    else
      redirect_to @dm, alert: "メッセージの追加に失敗しました"
    end
  end

  def create
    dm = Dm.find_or_create_by_users(@users << current_user)
    dm.dmmessages.build(content: message_params[:content], user: current_user)

    if dm.save
      session[:message_to] = nil
      redirect_to dm
    else
      redirect_to new_dm_url, alert: "メッセージの登録に失敗しました"
    end
  end

private
  def redirect_when_users_not_selected
    unless session[:message_to].present?
      redirect_to dms_users_url, alert: "メッセージの送付先を選択してください"
    end
  end

  def set_dm
    @dm = Dm.find(params[:id])
  end

  def set_users_from_session
    @users = User.where(id: session[:message_to]).order(:id)
  end

  def message_params
    params.require(:dmmessage).permit(:content)
  end
end
