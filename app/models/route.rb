class Route < ApplicationRecord
  self.primary_key = :id

  def self.ignore
    [ 1, 2, 3, 4, 5, 6 ]
  end
end
