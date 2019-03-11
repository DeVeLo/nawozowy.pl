class User < ApplicationRecord
  ROLES = %i[admin specjalista]
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  after_create :set_instytucja
  after_create :set_role
  
  belongs_to :instytucja

  def role?(type)
    self.role.underscore.to_sym == type
  end

  def set_instytucja
    self.update(instytucja_id: "58bd02b5-ffbd-4226-b512-71af8078df9f")
  end

  def set_role
    self.update(role: :specjalista)
  end
  
end
