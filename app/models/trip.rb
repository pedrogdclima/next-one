class Trip < ApplicationRecord
    belongs_to :shape
    self.primary_key = :id
end
