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

    describe 'validations' do
      it 'raises error when 4 selected dice' do
        expect{ Farkle::StandardScorer.score!([6, 6, 6, 6]) }.to raise_error
      end

      it 'raises error when given a string' do
        expect{ Farkle::StandardScorer.score("123") }.to raise_error
      end

      it 'raises an error when given a single that cannot be scored' do
       expect{ Farkle::StandardScorer.score!([3]) }.to raise_error
      end
    end
  end
end
