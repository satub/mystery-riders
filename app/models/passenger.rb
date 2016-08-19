class Passenger < ActiveRecord::Base
  has_secure_password

  validates_presence_of :alias, on: :create
  validates_presence_of :password, on: :create
  validates_presence_of :email, on: :create

  validates_uniqueness_of :alias, :email

  validates_format_of :email, with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i

  validates_length_of :alias, within: 4..20, too_long: 'alias maximum length is 20 characters', too_short: 'alias minimum length is 4 characters'
  validates_length_of :password, minimum: 6, too_short: 'password needs to be at least 6 characters long'

  has_many :ride_feedbacks
  has_many :subway_lines, :through => :ride_feedbacks
end
