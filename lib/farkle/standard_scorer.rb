 module Farkle
  class StandardScorer
    class << self
      def score!(dice)
        validate_selection(dice)
        case dice
        when [1]
         100
        when [5]
         50
        when [1,1,1]
         1000
        else
          score_triplet(dice)
        end
      end

      private

      def score_triplet(triplet)
        triplet.first * 100
      end

      def validate_selection(dice)
        size = dice.size
        raise 'only singles and triplets can be scored' unless size == 1 || size == 3
        if size == 1 && !([1, 5].include?(dice.first))
          raise "#{dice.first} cannot be scored"
        end
      end
    end
  end
end