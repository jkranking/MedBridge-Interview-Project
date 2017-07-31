require_relative '../game_views/play_game_view'
require_relative '../helpers/dice'

class PlayGame

  def initialize(game_model)
    @game_model = game_model
  end

	def start
		handle_randomize_players
		players = handle_get_players
		while game_on? do
			show_transition
			show_start_round
			handle_rotate_players
			players.each do |current_player|
				show_transition
				if player_needs_dice_score?(current_player)
					show_new_turn(current_player)
					handle_dice_roll(current_player.dice_needed)
					handle_last_round(current_player)
					handle_player_scores_and_response(current_player, current_player.dice_needed)
				else
					show_picked_all_dice(current_player)
				end
			end
			handle_next_round
		end
		show_transition
		show_winner
	end

	private

	def game_on?
		@game_model.round <=4
	end

	def finished_turn?(response)
		response.downcase == "done"
	end

	def last_round?
		@game_model.round == 4
	end

	def picked_at_least_one?(current_player, dice_needed_before_turn)
		current_player.dice_needed != dice_needed_before_turn
	end

	def player_needs_dice_score?(current_player)
		current_player.dice_needed > 0
	end

	def valid_response?(response)
		@game_model.check_valid_response?(response)
	end

	def handle_pick_dice
		show_pick_dice
		gets.chomp
	end

	def handle_last_round(current_player)
		if last_round?
			show_last_round(@game_model.dice_roll_for_round)
			@game_model.last_round_default_play(current_player)
		end
	end

	def handle_get_players
		@game_model.players
	end

	def handle_player_scores_and_response(current_player, dice_needed_before_turn)
		while player_needs_dice_score?(current_player) do
			response = handle_pick_dice
			if finished_turn?(response)
				if !picked_at_least_one?(current_player, dice_needed_before_turn)
					show_pick_one_error
				else
					break
				end
			elsif valid_response?(response)
				handle_valid_response(response, current_player)
			else
				show_valid_response_error
			end
		end
	end

	def handle_dice_roll(dice_needed)
		@game_model.dice_roll_for_round = Dice.get_dice_scores(dice_needed)
	end

	def handle_randomize_players
		@game_model.randomize_players
	end

	def handle_rotate_players
		if @game_model.round > 1 
			players = @game_model.rotate_players
		end 
	end

	def handle_valid_response(response, current_player)
		@game_model.add_dice_score(response, current_player)
		dice_scores = @game_model.remove_die(response)
	end

	def handle_next_round
		@game_model.round+=1
	end

	def show_new_turn(current_player)
		puts PlayGameView.new_turn(current_player)
	end

	def show_transition
		puts PlayGameView.cool_transition
	end

	def show_start_round
		puts PlayGameView.current_round(@game_model.round)
	end

	def show_last_round(dice_roll_for_round)
		puts PlayGameView.last_round(dice_roll_for_round)
	end

	def show_pick_one_error
		puts PlayGameView.pick_one_error
	end

	def show_pick_dice
		puts PlayGameView.pick_dice(@game_model.dice_roll_for_round)
	end

	def show_valid_response_error
		puts PlayGameView.valid_response_error
	end

	def show_winner
		winner = @game_model.find_player_with_lowest_score
		puts PlayGameView.print_winner(winner)
	end

	def show_picked_all_dice(current_player)
		puts PlayGameView.picked_all_dice(current_player)
	end

end
