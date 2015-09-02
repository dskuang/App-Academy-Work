require 'date'

class Cat < ActiveRecord::Base
  has_many :cat_rental_requests

  validates :color, :sex, presence: true
  validates :color, inclusion: ['red', 'black', 'white', 'brown']
  validates :sex, inclusion: ['M','F']

  def age
    now = Date.parse(Time.now.to_s)
    ((now - self.birth_date).to_i/365).abs
  end

end
