class Country < ActiveRecord::Base

  has_many :films,->{order(:name)}, dependent: :nullify

  validates :name, presence: true, uniqueness: true

  scope :ordering,->{order(:name)}

  before_destroy :can_destroy?

  def edit?(u)
    u && u.admin?
  end

  def self.add?(u)
     u && u.admin?
  end

  def can_destroy?
    films.blank?
  end
end
