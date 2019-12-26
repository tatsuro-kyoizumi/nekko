class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :posts, dependent: :destroy
  accepts_nested_attributes_for :posts, reject_if: :all_blank, allow_destroy: true
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  # フォロー・フォロワー関係
  has_many :active_relationships, class_name: "Relationship", foreign_key:"follower_id", dependent: :destroy
  has_many :passive_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower


  # refileによるプロフィール設定用
  attachment :profile_image

  geocoded_by :user_address,
    latitude: :fetched_latitude,
    longitude: :fetched_longitude
  after_validation :geocode, if: :user_address_changed?
  reverse_geocoded_by :latitude, :longitude

  paginates_per 3

  def follow(other_user)
    following << other_user
  end

  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  def following?(other_user)
    following.include?(other_user)
  end

  class << self
    def within_box(distance, latitude, longitude)
      distance = distance
      center_point = [latitude, longitude]
      box = Geocoder::Calculations.bounding_box(center_point, distance)
      self.within_bounding_box(box)
    end
  end
end
