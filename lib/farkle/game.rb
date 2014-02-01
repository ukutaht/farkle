module Farkle
  class Game
    attr_accessor :dice, :players
    attr_reader :presenter, :scorer, :winner

    WINNING_POINTS = 10_000

    def initialize(opts={})
      @scorer    = opts.fetch(:scorer) { Farkle::StandardScorer }
      @presenter = opts.fetch(:presenter) { Farkle::CLI_Presenter.new(self) }
      @dice      = [Farkle::Die.new, Farkle::Die.new, Farkle::Die.new, Farkle::Die.new, Farkle::Die.new, Farkle::Die.new]
      @players   = []
    end

    def play
      presenter.start_game
      until end_game?
        play_turn
        players.rotate!
      end
      end_game
      presenter.present_winner
    end

    def play_turn
      reset_dice
      turn_score = 0
      until presenter.bank_score?(turn_score)
        dieroll
        presenter.farkle and return if farkle?
        selection = collect_selection
        selection.each{|die| die.mark_scored! }
        score = scorer.score!(selection.map(&:value))
        presenter.show_score(score)
        turn_score += score
        check_hot_dice
      end
      current_player.score += turn_score
    end

    def end_game
      presenter.end_game
      (players.count - 1).times do
        play_turn
      end
    end

    def unscored_dice
      dice.reject(&:scored?)
    end

    def current_player
      players.first
    end

    def scoring_rules
      scorer.rules
    end

    def winner
      players.max_by{|player| player.score}
    end

    def winning_points
      WINNING_POINTS
    end

    private

    def collect_selection
      selection = presenter.get_selection.map{|i| dice[i - 1]}
      until scorer.can_score?(selection.map(&:value))
          presenter.try_selecting_again
          selection = presenter.get_selection.map{|i| dice[i - 1]}
      end
      selection
    end

    def dieroll
      presenter.dieroll
      dice.each{|die| die.roll unless die.scored?}
    end

    def farkle?
      !scorer.any_scorable_combinations?(unscored_dice.map(&:value))
    end

    def check_hot_dice
      if unscored_dice.empty?
        presenter.hot_dice
        reset_dice
      end
    end

    def reset_dice
      dice.each{|die| die.mark_unscored!}
    end

    def end_game?
      players.any?{|player| player.score >= WINNING_POINTS}
    end

  end
end