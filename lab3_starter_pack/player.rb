require_relative "element"
require_relative "history"
class Player
    attr_accessor :name, :history

    def initialize(name, history)
        @name = name
        @history = history
    end

    def play()
        fail "This method should be overridden"
    end
end

class StupidBot < Player
    def play()
        move = $moves[0] #rock in element global array
        history.log_play(move.name)
        return move
    end
end

class RandomBot < Player
    def play()
        move = $moves.sample #random move
        history.log_play(move.name)
        return move
    end
end

class IterativeBot < Player
    def initialize(name, history)
        super(name, history)
        @index = 0
    end

    def play()
        move = $moves[@index] #iterative
        history.log_play(move.name)
        if @index < 4
            @index += 1
        else
            @index = 0
        end
        return move
    end
end

class LastPlayBot < Player
    def initialize(name, history)
        super(name, history)
        @last_play = nil
    end

    def play()
        @last_play = history.opponent_plays.last
        if @last_play.nil?
            move = $moves[0] #play rock if no last move
        else
            move = $moves.find {|m| m.name == @last_play}
        end
        
        history.log_play(move.name)
        
        return move
    end
end

class Human < Player
    def get_index()
        puts "(1) Rock"
        puts "(2) Paper"
        puts "(3) Scissors"
        puts "(4) Lizard"
        puts "(5) Spock"
        print("Enter your move: ")
        index = gets.chomp
        unless index.match?(/^\d+$/) && (1..5).include?(index.to_i)
            puts "Invalid move - try again"
            index = get_index()
        end
        return index.to_i
    end
    def play()
        index = get_index() - 1
        move = $moves[index]
        history.log_play(move.name)
        return move
    end
end