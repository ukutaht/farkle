module Farkle
  class Game
    attr_reader :players

    def initialize(opts)
      @players = opts.fetch(:players)
      @scorer = Farkle::StandardScorer
      @presenter = Farkle::CLI_Presenter
    end

    def play
    end

  end
end