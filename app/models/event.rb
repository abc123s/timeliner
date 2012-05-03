class Event < ActiveRecord::Base
  attr_accessible :title, :description, :date

  belongs_to :category
  has_many :images
  has_many :videos
  has_many :audios
  has_many :locations

  validates :title, presence: true, length: { within: 3..50 }
  validates :date, presence: true

  default_scope order: 'events.date ASC'
end
