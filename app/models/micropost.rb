class Micropost < ApplicationRecord
  scope :desc, ->{order(created_at: :desc)}
  belongs_to :user
  mount_uploader :picture,PictureUploader
  validates :user_id,presence: true
  validates :content, presence: true ,length:{maximum:140}
  validate :picture_size

  def picture_size
    if picture.size > 5.megabytes
      errors.add(:picture, "should be less than 5BM")
    end
  end
end
