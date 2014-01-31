require 'spec_helper'

describe Farkle::Game do
  describe '#farkle?' do
    subject(:game) do
      Farkle::Game.new players:   [Farkle::Player.new("Uku"), Farkle::Player.new("Superman")],
                       presenter: double().as_null_object
    end
  end
end