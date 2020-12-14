class Application < ApplicationRecord
  validates_presence_of :name,
                        :description,
                        :street_address,
                        :city,
                        :state,
                        :zip,
                        :status
end
