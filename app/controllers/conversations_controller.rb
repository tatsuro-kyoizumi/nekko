class ConversationsController < ApplicationController

  def create
    # モデル内に定義したgetメソッドを使用してconversationの取得ならびに作成
    @conversation = Conversation.get(current_user.id, params[:user_id])

    add_to_conversations unless conversated?

    respond_to do |format|
      format.js
    end
  end

  def close
    @conversation = Conversation.find(params[:id])

    session[:conversations].delete(@conversation.id)

    respond_to do |format|
      format.js
    end
  end

  def add_to_conversations
    session[:conversations] ||= []
    session[:conversations] << @conversation.id
  end

  def conversated?
    session[:conversations].include?(@conversation.id)
  end
end
