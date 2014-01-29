module Farkle
  class Die
    attr_accessor :scored, :value
    alias_method :scored?, :scored

    def initialize
      @scored = false
      @value = rand(6) + 1
    end

    def roll
      value = rand(6) + 1
    end

    def mark_unscored!
      scored = false
    end

    def mark_scored!
      scored = true
    end
  end
end