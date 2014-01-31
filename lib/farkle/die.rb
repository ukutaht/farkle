module Farkle
  class Die
    attr_accessor :scored, :value
    alias_method :scored?, :scored

    def initialize(opts = {})
      @scored = opts.fetch(:scored) { false }
      @value  = opts.fetch(:value)  { rand(6) + 1 }
    end

    def roll
      self.value = rand(6) + 1
    end

    def mark_unscored!
      self.scored = false
    end

    def mark_scored!
      self.scored = true
    end

    def to_s
      value.to_s
    end
  end
end