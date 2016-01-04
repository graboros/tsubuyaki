class DmsController < ApplicationController
  before_action :authenticate_user!
  before_action :redirect_when_users_not_selected, :set_users_from_session, only: %i(new create)
  before_action :set_dm, only: %i(show update)

  def index
    @dms = Dm.dmlist(current_user)
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
        render js: 'alert("メッセージ送付先を追加してください");';
      end
    end
  end

  def show
  end

  def new
  end

  def update
    msg = @dm.dmmessages.build()
    msg.content = params[:content]
    msg.user = current_user

    if msg.save
      redirect_to dm_path(@dm), notice: "メッセージを追加しました"
    else
      render dm_path(@dm), alert: "メッセージの追加に失敗しました"
    end
  end

  def create
    content = params[:content]

    if content.present?
      dm = Dm.find_or_create_by_users(@users << current_user)
      dm.try(:add_content_with_user, params[:content], current_user)

      if dm.save
        session[:message_to] = nil
        redirect_to dm_url(dm)
      else
        render :new, alert: "メッセージの登録に失敗しました"
      end
    else
      render :new, alert: "メッセージの内容を入力してください"
    end
  end

private
  def redirect_when_users_not_selected
    unless session[:message_to].present?
      redirect_to dms_users_path, alert: "メッセージの送付先を選択してください"
    end
  end

  def set_dm
    @dm = Dm.find(params[:id])
  end

  def set_users_from_session
    @users = User.where(id: session[:message_to]).order(:id)
  end
end
