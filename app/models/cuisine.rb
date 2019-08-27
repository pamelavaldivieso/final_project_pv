class Cuisine < ApplicationRecord
  # Direct associations

  has_many   :favorites,
             :dependent => :destroy

  has_many   :recipes,
             :dependent => :destroy

  # Indirect associations

  # Validations

end
