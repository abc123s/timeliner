class Image < ActiveRecord::Base
  attr_accessible :title
  belongs_to :event
end
