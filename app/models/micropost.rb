class Micropost < ApplicationRecord
  belongs_to :user

  mount_uploader :picture, PictureUploader

  validates :user_id, presence: true
  validates :title, presence: true,
    length: {maximum: Settings.micropost.max_title_length}
  validates :content, presence: true,
    length: {maximum: Settings.micropost.max_content_length}
  validate  :picture_size

  scope :micropost_sort, ->{order created_at: :desc}

  private

  def picture_size
    if picture.size > Settings.picture.size.megabytes
      errors.add :picture, I18n.t(".less_than_size")
    end
  end
end
