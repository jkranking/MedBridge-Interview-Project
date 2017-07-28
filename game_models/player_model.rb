class PlayerModel
	attr_reader :name
	attr_accessor :dice, :dice_needed, :score

	def initialize(name)
		@name = name
		@dice_needed = 5
		@score = 0
	end

end
