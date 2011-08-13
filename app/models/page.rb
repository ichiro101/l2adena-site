class Page < ActiveRecord::Base

  acts_as_list

  validates_presence_of :name
  validates_presence_of :content
  validates_presence_of :permalink
  validates_uniqueness_of :permalink

end
