class Message < ApplicationRecord
  belongs_to :user
  belongs_to :room
  has_one_attached :image

  # unlessで指定したメソッドの返り値がflaseの場合実行される
  validates :content, presence: true, unless: :was_attached?


  def was_attached?
    self.image.attached?
  end
end
