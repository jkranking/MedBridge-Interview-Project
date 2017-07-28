class PlayGameModel
  attr_accessor :players, :round, :dice_roll_for_round

  def initialize(players)
    @players = players
    @round = 1
    @dice_roll_for_round = []
  end

  def find_player_with_lowest_score
    lowest_player = []
    lowest = Float::INFINITY
    @players.each do |player|
      if player.score < lowest
        lowest = player.score
        lowest_player = [player]
      elsif player.score == lowest
        lowest_player.push(player)
      end
    end
    lowest_player
  end

  def randomize_players
    length = @players.length
    (0...length).each do |first_index|
      second_index = get_random(0, length - 1)
      if second_index != first_index
          @players[first_index], @players[second_index] = @players[second_index], @players[first_index]
      end
    end
  end

  def rotate_players
    shifted_player = @players.shift()
    @players.push(shifted_player)
  end

  def last_round_default_play(current_player)
    @dice_roll_for_round.each do |score| 
      current_player.score+=score
    end
    current_player.dice_needed=0
  end

  def add_dice_score(response, current_player)
    current_player.dice_needed-=1
    current_player.score+=response.to_i
  end

  def check_valid_response?(response)
    if response.to_i == 0 && response != "0"
      false
    else
      @dice_roll_for_round.include?(response.to_i)
    end
  end

  def remove_die(response)
    scores = @dice_roll_for_round
    scores.delete_at(scores.find_index(response.to_i))
    scores
  end

  private

  def get_random(floor, ceiling)
    rand(floor..ceiling)
  end

end
