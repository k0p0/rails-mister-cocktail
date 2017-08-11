class Cocktail < ApplicationRecord
  has_many :doses, dependent: :destroy
  has_many :ingredients, through: :doses
  validates :name , presence: true, allow_nil: false, uniqueness: true
  validates :instruction , presence: true, allow_nil: false
  mount_uploader :photo, PhotoUploader
end
