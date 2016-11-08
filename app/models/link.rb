require 'uri'

class Link < ActiveRecord::Base
  belongs_to :user
  validates :url, presence: true,
                  format: { with: URI::regexp(%w(http https)) }
  validates :title, presence: true

  def self.parse(link)
    input = link.split(' ')
  end
end
