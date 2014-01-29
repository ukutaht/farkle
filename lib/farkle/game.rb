module Farkle
  class Game
    attr_reader :players, :presenter, :scorer, :winner, :dice
    DEFAULTS = { scorer:    Farkle::StandardScorer,
                 presenter: Farkle::CLI_Presenter.new(self),
                 dice:      [Farkle::Die.new, Farkle::Die.new, Farkle::Die.new, Farkle::Die.new, Farkle::Die.new, Farkle::Die.new]}

    def initialize(opts)
      opts = DEFAULTS.merge(opts)

      @players   = opts.fetch(:players)
      @scorer    = opts.fetch(:scorer)
      @presenter = opts.fetch(:presenter)
      @dice      = opts.fetch(:dice)
    end

    def play
      presenter.start_game
      until game_over?
        play_turn
        players.rotate!
      end
      presenter.present_winner
    end

    def play_turn
      reset_dice
      until presenter.bank_score? || game_over?
        dieroll
        break if farkle?
        selected_dice = presenter.get_selection
        current_player.score += scorer.score!(selected_dice)
        selected_dice.each{|die| die.mark_scored! }
      end
    end

    private

    def farkle?
      !(dice.include?(5) || dice.include?(1) ||
        dice.permutation(3).any?{ |triplet| triplet.uniq.length == 1 })
    end

    def reset_dice
      dice.each{|die| die.mark_unscored!}
    end

    def dieroll
      dice.each{|die| die.roll unless die.scored?}
    end

    def current_player
      players.first
    end

    def game_over?
      players.any?{|player| player.score >= 10_000}
    end

    def winner
      players.find{|player| player.score >= 10_000}
    end

  end
end