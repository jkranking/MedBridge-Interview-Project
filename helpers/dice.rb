module Dice

  def self.get_dice_scores(dice_left)
  	scores = []
  	dice_left.times { scores.push(roll_die) }
  	scores
  end

  def self.roll_die
  	score = rand(6)+1
  	if score == 4
  		0
  	else
  		score
  	end
  end

end
