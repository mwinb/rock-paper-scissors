require_relative '../lib/game'

describe 'A game of rock paper scissors' do

  it 'exists' do
    Game.new
  end

  it 'can start' do
    Game.new.start
  end

  it 'is not initially started' do
    game = Game.new
    expect(game).to_not be_started
  end

  it 'a started game knows that it has started' do
    game = Game.new
    game.start
    expect(game).to be_started
  end
  
  describe 'playing' do
    
    let (:game) {Game.new}

    context 'without starting' do
      it 'can not be played if it has not started' do
        expect { game.play }.to raise_error(RuntimeError)
      end
    end

    context 'after starting' do
      it 'can be played if it has started' do
        game.start
        expect { game.play }.to_not raise_error
      end

      it 'returns nil when not provided with anything' do
        game.start
        expect(game.play).to be_nil
      end

      it 'returns nil when only provided one rock, paper or scissor' do
        game.start
        expect(game.play(:FAKE)).to be_nil
      end

      it 'does not return nil when two objects are provided' do
        game.start
        expect(game.play(:FAKE, :FAKE)).to_not be_nil
      end
    end

    context 'rock vs scissors' do
      it 'announces the correct winner' do
        game.start
        expect(game.play(:rock, :scissors)).to eq("Rock beats scissors!")
        expect(game.play(:scissors, :rock)).to eq("Rock beats scissors!")
      end

      it 'expects game to be finished' do
        game.start 
        game.play(:rock, :scissors)
        expect(game.finished?).to be(true)
      end
    end

    context 'rock vs paper' do
      it 'announces the correct winner' do
        game.start
        expect(game.play(:paper, :rock)).to eq("Paper beats rock!")
        expect(game.play(:rock, :paper)).to eq("Paper beats rock!")
        expect(game.finished?).to be(true)
      end

      it 'expects game to be finished' do
        game.start 
        game.play(:rock, :paper)
        expect(game.finished?).to be(true)
      end
    end


    context 'scissors vs paper' do
      it 'announces the correct winner' do
        game.start
        expect(game.play(:scissors, :paper)).to eq("Scissors beats paper!")
        expect(game.play(:paper, :scissors)).to eq("Scissors beats paper!")
      end

      it 'expects game to be finished' do
        game.start 
        game.play(:paper, :scissors)
        expect(game.finished?).to be(true)
      end
    end

    context 'a tie game' do
      
      it 'announces a tie game' do
        game.start
        expect(game.play(:scissors, :scissors)).to eq("Tie game. Try again!")
        expect(game.play(:paper, :paper)).to eq("Tie game. Try again!")
        expect(game.play(:rock, :rock)).to eq("Tie game. Try again!")
      end

      it 'expects game to not be finished' do
        game.start 
        game.play(:scissors, :scissors)
        expect(game.finished?).to be(false)
      end
    end

  end

end
