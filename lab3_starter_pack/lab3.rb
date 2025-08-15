require_relative "element"   # uncomment to load element.rb
require_relative "player"    # uncomment to load player.rb 
require_relative "history"   # uncomment to load history.rb

######################################### 	
#     CS 381 - Programming Lab #3		#
#										#
#  < your name >	Padraic Bergin				 	#
#  < your email >	 Berginp@oregonstate.edu               	#
#										#
#########################################



# your code here
$player_string = []
def pick_character()
	print "Select player 1:"
	player1 = gets.chomp
	print "Select player 2:"
	player2 = gets.chomp
        unless player1.match?(/^\d+$/) && player2.match?(/^\d+$/) && (1..5).include?(player1.to_i) && (1..5).include?(player2.to_i) 
            puts "Invalid choice(s) - start over"
            player1, player2 = pick_character()
        end
	return player1.to_i, player2.to_i
end

def assign_player(player,name)
	if player == 1
		$player_string.push("StupidBot")
		return StupidBot.new(name, History.new)
	elsif player == 2
		$player_string.push("RandomBot")
		return RandomBot.new(name, History.new)
	elsif player == 3
		$player_string.push("IterativeBot")
		return IterativeBot.new(name, History.new)
	elsif player == 4
		$player_string.push("LastPlayBot")
		return LastPlayBot.new(name, History.new)
	elsif player == 5
		$player_string.push("Human")
		return Human.new(name, History.new)
	end
end

def assign_players(player1, player2)
	p1 = assign_player(player1,"Player 1")
	p2 = assign_player(player2, "Player2")
	return p1, p2
end

def round(p1,p2)
	p1move = p1.play()
	p2move = p2.play()
	puts "Player 1 chose #{p1move.name}"
	puts "Player 2 chose #{p2move.name}"
	p1.history.log_opponent_play(p2move.name)
	p2.history.log_opponent_play(p1move.name)
	event, result = p1move.compare_to(p2move)
	puts "#{event}"
	if result == "Win"
		p1.history.add_score
		puts "Player 1 won the round"
	elsif result == "Lose"
		p2.history.add_score
		puts "Player 2 won the round"
	elsif result == "Tie"
		puts "Round was a tie"
	end
	puts ""
end


def game(rounds)
	puts "Welcome to Rock, Paper, Scissors, Lizard, Spock!"
	puts ""
	puts "Please choose two players:"
	puts "(1) StupidBot
(2) RandomBot
(3) IterativeBot
(4) LastPlayBot
(5) Human"
	player1_type, player2_type = pick_character()
	p1, p2 = assign_players(player1_type, player2_type)
	puts "#{$player_string[0]} vs. #{$player_string[1]}"
	puts ""
	while rounds > 0 
		puts "Round #{6 - rounds}:"
		round(p1,p2)
		rounds -= 1
	end
	puts "Final score is #{p1.history.score} to #{p2.history.score}"
	if p1.history.score > p2.history.score
		puts "Player 1 wins"
	elsif p1.history.score < p2.history.score
		puts "Player 2 wins"
	elsif p1.history.score == p2.history.score
		puts "Game was a draw"
	end
	
end


# Main Program (should be last)
n_rounds = 5
# call to kick off the game
game(n_rounds)