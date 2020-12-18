class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def self.partial_match(keyword, column)
    where("#{column} like ?", "%#{keyword.downcase.capitalize}%")
  end

  def self.alphabetical
    order(name: :desc)
  end

end
