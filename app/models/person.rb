class Person < ActiveRecord::Base
  SEX=%w(мужской женский)

  attr_reader :person_tokens

  has_and_belongs_to_many :films, ->{order(:name)}
  has_many :produced_films, ->{order(:name)}, class_name: 'Film', foreign_key: :director_id

  has_attached_file :avatar, styles: {thumb: "100x100>", medium: "250x250>"}


  validates :name, presence: true
  validates_attachment :avatar, content_type: {content_type: /\Aimage\//}, size: {in: 0..10.megabytes}


  scope :ordering, ->{order(:name)}

  before_destroy :can_destroy?


  def edit?(u)
    u && u.admin?
  end

  def self.add?(u)
    u && u.admin?
  end

  def sex
    return if male.nil?
    SEX[male? ? 0 : 1]
  end

  def can_destroy?
    films.blank? && produced_films.blank?
  end

  def serializable_hash(options={})
    options.merge(only: [:id,:name])
    super(options)
  end

end
