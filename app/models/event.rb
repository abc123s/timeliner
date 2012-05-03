class Event < ActiveRecord::Base
  attr_accessible :title, :description, :date, :location_attributes, :audio_attributes, :video_attributes, :image_attributes

  belongs_to :category
  has_one :image
  has_one :video
  has_one :audio
  has_one :location

  validates :title, presence: true, length: { within: 3..50 }
  validates :date, presence: true

  default_scope order: 'events.date ASC'
  accepts_nested_attributes_for :location
  accepts_nested_attributes_for :audio
  accepts_nested_attributes_for :video
  accepts_nested_attributes_for :image
end
