module Farkle
  class Game
    attr_accessor :dice, :players
    attr_reader :presenter, :scorer, :winner
    DEFAULTS = { scorer:    Farkle::StandardScorer,
                 dice:      [Farkle::Die.new, Farkle::Die.new, Farkle::Die.new, Farkle::Die.new, Farkle::Die.new, Farkle::Die.new]}
    WINNING_POINTS = 10_000

    def initialize(opts)
      opts = DEFAULTS.merge(opts)

      @scorer    = opts.fetch(:scorer)
      @presenter = opts.fetch(:presenter) { Farkle::CLI_Presenter.new(self) }
      @dice      = opts.fetch(:dice)
      @players   = []
    end

    def play
      presenter.start_game
      until end_game?
        play_turn
        players.rotate!
      end
      presenter.end_game
      end_game
      presenter.present_winner
    end

    def play_turn
      reset_dice
      turn_score = 0
      until presenter.bank_score?(turn_score)
        presenter.dieroll
        dieroll
        if farkle?
          presenter.farkle
          return
        end
        selected_dice = presenter.get_selection
        score = scorer.score!(selected_dice.map(&:value))
        presenter.show_score(score)
        turn_score += score
        selected_dice.each{|die| die.mark_scored! }
        check_hot_dice
      end
      current_player.score += turn_score
    end

    def end_game
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

    private

    def check_hot_dice
      if unscored_dice.empty?
        presenter.hot_dice
        reset_dice
      end
    end

    def farkle?
      !scorer.any_scorable_combinations?(unscored_dice.map(&:value))
    end

    def reset_dice
      dice.each{|die| die.mark_unscored!}
    end

    def dieroll
      dice.each{|die| die.roll unless die.scored?}
    end

    def end_game?
      players.any?{|player| player.score >= WINNING_POINTS}
    end

    def winner
      players.max_by{|player| player.score}
    end

  end
end