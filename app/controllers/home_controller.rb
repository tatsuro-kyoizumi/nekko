class HomeController < ApplicationController

  def top
    
  end
  # ここで一時的にチャット用ページ作成
  def index
    # conversationsが存在していればそれを代入、なければ空で返す
    session[:conversations] ||= []

    # current_user以外のユーザーを取得
    @users = User.all.where.not(id: current_user.id)

    # N+1問題を避けながら、conversationsを探す
    @conversations = Conversation.includes(:recipient, :messages).find(session[:conversations])
  end
end
