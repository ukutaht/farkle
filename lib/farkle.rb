require_relative 'farkle/player.rb'
require_relative 'farkle/die.rb'
require_relative 'farkle/standard_scorer.rb'
require_relative 'farkle/cli_presenter.rb'
require_relative 'farkle/game.rb'

game = Farkle::Game.new players: [Farkle::Player.new("Uku"), Farkle::Player.new("Superman")]
game.play