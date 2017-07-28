module PlayGameView
	def self.new_turn(player)
		"It's #{player.name}'s turn! Current Score - #{player.score}. Rolling the dice...\n\n"
	end

	def self.pick_dice(dice_scores)
		"Please pick a score - #{dice_scores}. Type 'done' if finished"
	end

	def self.pick_one_error()
		"You must pick at least one"
	end

	def self.valid_response_error
		"Please type a valid response"
	end

	def self.print_winner(winner)
		if winner.length > 1
			winners = []
			winner.each {|player| winners.push(player.name)}
			"It's a tie between #{winners.join(" and ")} with a score of #{winner[0].score}"
		else 
			single_winner = winner.pop()
  		"#{single_winner.name} is the winner with the lowest score of #{single_winner.score}"
  	end
	end

	def self.last_round(dice_scores)
  	"Its the last round...the following rolls will be added to your score - #{dice_scores}"
	end

	def self.current_round(round)
		"Round #{round}\n\n"
	end

	def self.cool_transition
		"\n~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~\n"
	end

	def self.picked_all_dice(current_player)
		"#{current_player.name} has picked all 5 dice and has a final score of #{current_player.score}\n\n"
	end
end
