class Category < ActiveRecord::Base
  attr_accessible :title, :events_attributes

  belongs_to :timeline
  has_many :events

  validates :title, presence: true, length: { within: 3..50 }
  
  accepts_nested_attributes_for :events, :reject_if => proc { |attributes| attributes['title'].blank? }
end
