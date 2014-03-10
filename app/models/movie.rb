class Movie < ActiveRecord::Base
  validates :title, :released_on, :duration, presence:true,uniqueness: :true
  validates :slug, uniqueness: true
  validates :description, length: { minimum:25 }
  validates :total_gross, numericality: { greater_than_or_equal_to: 0 }
  has_attached_file :image
  validates_attachment :image,
                       :content_type => { content_type: ['image/jpeg', 'image/png'] },
                       :size => { less_than: 1.megabyte }



  before_validation :generate_slug

  has_many :reviews, dependent: :destroy
  has_many :favourites, dependent: :destroy
  has_many :fans, through: :favourites, source: :user
  has_many :characterizations, dependent: :destroy
  has_many :genres, through: :characterizations

  RATINGS = %w(G PG PG-13 R NC-17)
  validates :rating, inclusion: { in: RATINGS }

  scope :released, -> {  where("released_on <= ?", Time.now).order(released_on: :desc)  }
  scope :hits, -> {  released.where('total_gross >= 300000000').by_gross  }
  scope :by_gross, -> { order('total_gross desc') }
  scope :flops, -> {  released. where('total_gross < 10000000').by_gross  }
  scope :recently_added, -> {  released.order('created_at desc').limit(3)  }
  scope :upcoming, -> {  where("released_on > ?", Time.now).order(released_on: :asc)  }
  scope :rated, ->(ratingdesc) { where("rating=?",ratingdesc)}
  scope :recent, ->(max=5) { released.limit(max) }

  #def self.released
  #  where("released_on <= ?", Time.now).order("released_on desc")
  #end
  
  #def self.hits
  #  where('total_gross >= 300000000').order('total_gross desc')
  #end
  #
  #def self.flops
  #  where('total_gross < 10000000').order('total_gross asc')
  #end
  #
  #def self.recently_added
  #  order('created_at desc').limit(3)
  #end
  
  def flop?
    total_gross.blank? || total_gross < 50000000
  end
  
  
  def flop?
    total_gross.blank? || total_gross < 50000000
  end

  def average_stars
    reviews.average(:stars)
  end

  def to_param
    #"#{self.id}-#{self.title.parameterize}"
    slug
  end

  def generate_slug
    self.slug ||= title.parameterize if title
  end

end
