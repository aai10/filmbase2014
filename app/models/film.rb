class Film < ActiveRecord::Base
  belongs_to :country
  belongs_to :genre
  belongs_to :director, class_name: 'Person'
  has_and_belongs_to_many :people, -> { order(:name) }

  attr_reader :person_tokens

  has_attached_file :cover, styles: {thumb: "100x100>", medium: "250x250>"}

  validates :name, presence: true
  validates :country, presence: true
  validates :director, presence: true
  validates :genre, presence: true
  validates :length, numericality: {only_integer: true, greater_than: 0}, allow_blank: true
  validates :year, numericality: {only_integer: true, greater_than: 1885},allow_blank: true

  validate :check_people

  scope :ordering, ->{order(:name)}
  scope :short, ->{includes(:genre)}
  scope :full, ->{includes(:country,:genre,:director,:people)}

  def human_length
    "#{length} мин"
  end


  def edit?(u)
    u && u.admin?
  end

  def self.add?(u)
    u && u.admin?
  end

  def person_tokens=(val)
    self.person_ids=val.split(',')
  end

  private

  def check_people
    errors.add(:base,"Актеры отсутствуют") if people.blank?
  end


end
