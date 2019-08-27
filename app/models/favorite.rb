class Favorite < ApplicationRecord
  # Direct associations

  belongs_to :cuisine

  belongs_to :recipes,
             :class_name => "Recipe"

  belongs_to :user

  # Indirect associations

  # Validations

end
