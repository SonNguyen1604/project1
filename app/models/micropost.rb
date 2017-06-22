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
  scope :load_feed, ->(id, following_ids) do
    where "user_id IN (#{following_ids}) OR user_id = :user_id",
      following_ids: following_ids, user_id: id
  end

  private

  def picture_size
    if picture.size > Settings.picture.size.megabytes
      errors.add :picture, I18n.t(".less_than_size")
    end
  end
end
