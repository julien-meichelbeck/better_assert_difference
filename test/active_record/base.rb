module ActiveRecord
  class Base
    @@items = []

    def self.create
      @@items << 1
      true
    end

    def self.all
      @@items
    end

    def self.count
      @@items.count
    end

    def self.reset_count
      @@items = []
    end

    def self.reload
      self
    end
  end
end
