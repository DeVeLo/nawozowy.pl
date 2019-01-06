class Staly < ApplicationRecord
  has_and_belongs_to_many :grunty
  has_and_belongs_to_many :gminy
end
