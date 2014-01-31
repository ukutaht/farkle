describe Farkle::StandardScorer do
  describe 'score!' do
    context 'single 1' do
      it 'scores 100 points' do
        Farkle::StandardScorer.score!([1]).should eq 100
      end
    end

    context 'single 5' do
      it 'scores 50 points' do
        Farkle::StandardScorer.score!([5]).should eq 50
      end
    end

    context 'triple 1' do
      it 'scores 1000 points' do
        Farkle::StandardScorer.score!([1, 1, 1]).should eq 1000
      end
    end

    context 'triple 6' do
       it 'scores 600 points' do
        Farkle::StandardScorer.score!([6 ,6, 6]).should eq 600
      end
    end
  end

  describe '#can_score?' do
      it 'is false when 4 selected dice' do
        Farkle::StandardScorer.can_score?([6, 6, 6, 6]).should be_false
      end

      it 'is false when given a string' do
        Farkle::StandardScorer.can_score?("123").should be_false
      end

      it 'is false when given a single that cannot be scored' do
       Farkle::StandardScorer.can_score?([3]).should be_false
      end

      it 'is true for a 5' do
        Farkle::StandardScorer.can_score?([5]).should be_true
      end

      it 'is true for a 1' do
        Farkle::StandardScorer.can_score?([1]).should be_true
      end

      it 'is true for atriplet of 2s' do
        Farkle::StandardScorer.can_score?([2, 2, 2]).should be_true
      end
    end

    describe '#any_scorable_combinations?' do
      it 'is true when a single 1 can be scored' do
        Farkle::StandardScorer.any_scorable_combinations?([1, 2, 2, 3, 4, 6]).should be_true
      end

      it 'is true when a single 5 can be scored' do
        Farkle::StandardScorer.any_scorable_combinations?([3, 2, 2, 3, 5, 6]).should be_true
      end

      it 'is true when a triplet can be scored' do
        Farkle::StandardScorer.any_scorable_combinations?([3, 2, 2, 4, 5, 6]).should be_true
      end

      it 'is false when nothing be scored' do
        Farkle::StandardScorer.any_scorable_combinations?([3, 2, 4, 2, 3, 6]).should be_false
      end

      it 'is false when nothing be scored with 1 die' do
        Farkle::StandardScorer.any_scorable_combinations?([3]).should be_false
      end
    end
end
