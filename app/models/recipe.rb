class Recipe < ApplicationRecord
  # Direct associations

  has_many   :favorites,
             :foreign_key => "recipes_id",
             :dependent => :destroy

  belongs_to :user

  # Indirect associations

  # Validations

end
