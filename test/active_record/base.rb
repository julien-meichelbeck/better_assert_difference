module ActiveRecord
  class Base
    @@counter = 0

    def self.create
      @@counter += 1
      true
    end

    def self.count
      @@counter
    end

    def self.reset_count
      @@counter = 0
    end
  end
end
