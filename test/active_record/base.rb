module ActiveRecord
  class Base
    @@items = []

    def self.create
      @@items << 1
      true
    end

    def self.all
      @@items
      self
    end

    def self.count
      @@items.count
    end

    def self.reset_count
      @@items = []
    end

    def self.reset
      self
    end
  end
end
