# coding: utf-8
class Rolnik < ApplicationRecord
  belongs_to :wojewodztwo
  belongs_to :powiat
  belongs_to :gmina
  belongs_to :instytucja
  has_many :zlecenia, dependent: :destroy

  validates :wojewodztwo_id, :powiat_id, :gmina_id, presence: true

  before_save :make_keywords

  scope :search, -> (keywords) { where("keywords iLIKE ?", "%" + keywords.to_s + "%") }

  private
  # tworzy słowa kluczowe,
  # po których będzie można wyszukiwać rolnika
  def make_keywords
    self.keywords = self.name.to_s + " " +
                    self.lname.to_s + " " +
                    self.gname.to_s + " " +
                    self.miejscowosc.to_s + " " +
                    self.nip.to_s + " " +
                    self.nig.to_s + " " +
                    self.ulica.to_s + " " +
                    self.kod.to_s + " " +
                    self.poczta.to_s + " " +
                    self.tel.to_s + " " +
                    self.kom.to_s + " " +
                    self.mail.to_s + " " +
                    make_keywords_from_zlecenia
  end

  def make_keywords_from_zlecenia
    keywords = ""
    self.zlecenia.each do |zlecenie|
      keywords += zlecenie.rejestr.to_s + '/' + ((zlecenie.typ)?'PP':'PA').to_s + '/' + zlecenie.datawplywu.year.to_s + " "
    end
    keywords
  end
  
end
