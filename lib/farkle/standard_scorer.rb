 module Farkle
  class StandardScorer
    class << self
      def score!(dice)
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

      def any_scorable_combinations?(dice)
        return false unless dice.is_a? Array

        dice.each{|die| return true if scorable_single?([die])} ||
          dice.permutation(3){|triplet| return true if scorable_triplet?(triplet)}
        false
      end

      def can_score?(dice)
        return false unless dice.is_a? Array

        scorable_single?(dice) || scorable_triplet?(dice)
      end

      def rules
        <<-RULES
          Dice combination | Score
          -----------------+------
          Each 1           | 100
          Each 5           | 50
          Three 1s         | 1000
          Three 2s         | 200
          Three 3s         | 300
          Three 4s         | 400
          Three 5s         | 500
          Three 6s         | 600
        RULES
      end

      private

      def scorable_single?(dice)
        dice.length == 1 && (dice.first == 1 || dice.first == 5)
      end

      def scorable_triplet?(dice)
        dice.length == 3 && dice.uniq.length == 1
      end

      def score_triplet(triplet)
        triplet.first * 100
      end
    end
  end
end