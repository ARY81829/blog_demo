class Post < ApplicationRecord
  belongs_to :user
  has_one_attached :image

  validates :title, presence: true, length: { minimum: 3, maximum: 100 }
  validates :body, presence: true, length: { minimum: 10 }
  validate :image_type_and_size

  private

  def image_type_and_size
    return unless image.attached?

    if !image.content_type.in?(%w(image/png image/jpg image/jpeg))
      errors.add(:image, "muss PNG oder JPG sein")
    elsif image.blob.byte_size > 5.megabytes
      errors.add(:image, "darf nicht größer als 5MB sein")
    end
  end
end
