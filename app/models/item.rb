class Item < ApplicationRecord
  belongs_to :genre
  has_many :cart_items

  has_one_attached :image

  validates :name, presence: true
  validates :introduction, presence: true
  validates :notax_price, presence: true,numericality: {only_integer: true}
  validates :genre_id, presence: true

  def get_image
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image
  end

  def add_tax_price
    (notax_price * 1.10).floor
  end
end
