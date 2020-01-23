class Post < ApplicationRecord

  validates :title, presence: true, length: { maximum: 10}
  validates :text, presence: true, length: { maximum: 50}

  belongs_to :user
  paginates_per 10
end
