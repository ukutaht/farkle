require 'spec_helper'

describe Farkle::Game do
  describe '#play' do
    subject(:game) do
      Farkle::Game.new players:   [Farkle::Player.new("Uku"), Farkle::Player.new("Superman")],
                       presenter: double().as_null_object
    end

    it 'recognises a farkle' do
      game.presenter.stub(:get_selection).and_return(nil)
      game.play
    end
  end
end