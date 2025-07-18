class Project < ApplicationRecord
  has_many :tasks
  has_and_belongs_to_many :users

  scope :active, -> { where("current_date >= start_date AND current_date <= (start_date + (duration || ' seconds')::interval)::date") }

  def active?
    Date.today >= start_date && Date.today <= start_date + duration.seconds
  end
end
