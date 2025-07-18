class Task < ApplicationRecord
  attr_accessor :duration_type
  belongs_to :project
end
