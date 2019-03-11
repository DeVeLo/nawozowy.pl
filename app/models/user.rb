class User < ApplicationRecord
  ROLES = %i[admin specjalista]
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  belongs_to :instytucja

  def role?(type)
    self.role.underscore.to_sym == type
  end
  
end
