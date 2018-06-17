class ApplicationRecord < ActiveRecord::Base
  # enum role: { student: 0, driver: 1, admin: 2 }
  enum kind: { payu: 0, joined_to_journey: 1 }
  self.abstract_class = true
end
