require 'uri'

class Link < ActiveRecord::Base
  belongs_to :user
  validates :url, presence: true, format: URI::regexp(%w(http https))
  validates :title, presence: true
  validates :read, presence: true
end
