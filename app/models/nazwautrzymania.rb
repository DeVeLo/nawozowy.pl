class Nazwautrzymania < ApplicationRecord
  has_many :systemyutrzymania
  belongs_to :wspwykorzystania
end
