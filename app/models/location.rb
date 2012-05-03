class Location < ActiveRecord::Base
  attr_accessible :title, :longitude, :latitude
  belongs_to :event

  validates :longitude, presence: true
  validates :latitude, presence: true
end
