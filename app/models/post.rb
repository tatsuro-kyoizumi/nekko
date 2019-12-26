class Post < ApplicationRecord
  belongs_to :user
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :post_pictures, dependent: :destroy
  accepts_nested_attributes_for :post_pictures, reject_if: :all_blank, allow_destroy: true

  # validates :post_image, presence: true
  # refileによる投稿イメージ
  attachment :post_image

  # geocoderによる位置情報
  geocoded_by :address
  after_validation :geocode, if: :address_changed?
  reverse_geocoded_by :latitude, :longitude

  # acts_as_taggable_onによるタグ機能
  acts_as_taggable
  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

  # within_boxメソッドの定義
  class << self
    def within_box(distance, latitude, longitude)
      distance = distance
      center_point = [latitude, longitude]
      box = Geocoder::Calculations.bounding_box(center_point, distance)
      self.within_bounding_box(box)
    end
  end
end
