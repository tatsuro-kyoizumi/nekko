class Conversation < ApplicationRecord
  has_many :messages, dependent: :destroy
  belongs_to :sender, foreign_key: :sender_id, class_name: "User"
  belongs_to :recipient, foreign_key: :recipient_id, class_name: "User"

  # sender_idとrecipient_idのユニーク制約
  validates :sender_id, uniqueness: {scope: :recipient_id}

  # senderとrecipientによる非公開チャットの存在をscope betweenメソッドで定義
  scope :between, -> (sender_id, recipient_id) do
    where(sender_id: sender_id, recipient_id: recipient_id).or(where(sender_id: recipient_id, recipient_id: sender_id)
    )
  end

  # ユーザー間の会話の取得のため定義（もし会話が存在すればそれを返し、なければcreateする）
  def self.get(sender_id, recipient_id)
    conversation = between(sender_id, recipient_id).first
    if conversation.present?
        conversation

    else
    create(sender_id: sender_id, recipient_id: recipient_id)
    end
  end

  # 相手ユーザーを返すメソッドの定義
  def opposed_user(user)
    user == recipient ? sender : recipient
  end

end
