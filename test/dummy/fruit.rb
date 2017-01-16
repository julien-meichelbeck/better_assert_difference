class Fruit < ActiveRecord::Base
  def self.inspect
    "#{self.name} (name size price)"
  end
end
