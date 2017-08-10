class Dose < ApplicationRecord
  belongs_to :cocktail
  belongs_to :ingredient
  validates :description, presence: true, allow_nil: false, allow_blank: false
  validates :cocktail , presence: true
  validates :ingredient , presence: true
  validates :cocktail, uniqueness: { scope: :ingredient }
  validates :ingredient, :uniqueness => { :scope => :cocktail }
end
