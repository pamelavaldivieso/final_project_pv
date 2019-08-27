class Cuisine < ApplicationRecord
  # Direct associations

  has_many   :recipes,
             :dependent => :destroy

  # Indirect associations

  # Validations

end
