class Timeline < ActiveRecord::Base
  attr_accessible :title, :description, :ttype, :startdate, :enddate, :categories_attributes

  belongs_to :user
  has_many :categories

  validates :title, presence: true, length: { within: 3..50 }
  validates :ttype, presence: true

  accepts_nested_attributes_for :categories, :reject_if => proc { |attributes| attributes['title'].blank? }
end
