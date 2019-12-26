class PostPicture < ApplicationRecord
  belongs_to :post
  attachment :image
end
