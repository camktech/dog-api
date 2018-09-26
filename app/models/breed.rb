class Breed < ActiveRecord::Base
  validates_presence_of :name, :pic_url
  validates_uniqueness_of :name
end
