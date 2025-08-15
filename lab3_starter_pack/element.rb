class Element
    attr_accessor :name

    def initialize(name)
        @name = name
    end

    def compare_to(op)
        fail "This method should be overridden"
    end

end

class Rock < Element

    def compare_to(op)
        if op.name == "Scissors"
            return "#{name} crushes #{op.name}", "Win"
        elsif op.name == "Lizard"
            return "#{name} crushes #{op.name}", "Win"
        elsif op.name == name
            return "#{name} equals #{name}", "Tie"
        elsif op.name == "Spock"
            return "#{op.name} vaporizes #{name}", "Lose"
        elsif op.name == "Paper"
            return "#{op.name} covers #{name}", "Lose"
        end
    end
end

class Paper < Element

    def compare_to(op)
        if op.name == "Spock"
            return "#{name} disproves #{op.name}", "Win"
        elsif op.name == "Rock"
            return "#{name} covers #{op.name}", "Win"
        elsif op.name == name
            return "#{name} equals #{name}", "Tie"
        elsif op.name == "Scissors"
            return "#{op.name} cut #{name}", "Lose"
        elsif op.name == "Lizard"
            return "#{op.name} eats #{name}", "Lose"
        end
    end
end

class Scissors < Element

    def compare_to(op)
        if op.name == "Paper"
            return "#{name} cut #{op.name}", "Win"
        elsif op.name == "Lizard"
            return "#{name} decapitate #{op.name}", "Win"
        elsif op.name == name
            return "#{name} equals #{name}", "Tie"
        elsif op.name == "Rock"
            return "#{op.name} crushes #{name}", "Lose"
        elsif op.name == "Spock"
            return "#{op.name} smashes #{name}", "Lose"
        end
    end
end

class Spock < Element

    def compare_to(op)
        if op.name == "Rock"
            return "#{name} vaporizes #{op.name}", "Win"
        elsif op.name == "Scissors"
                return "#{name} smashes #{op.name}", "Win"
        elsif op.name == name
            return "#{name} equals #{name}", "Tie"
        elsif op.name == "Lizard"
            return "#{op.name} poisons #{name}", "Lose"
        elsif op.name == "Paper"
            return "#{op.name} disproves #{name}", "Lose"
        end
    end
end

class Lizard < Element

    def compare_to(op)
        if op.name == "Spock"
            return "#{name} poisons #{op.name}", "Win"
        elsif op.name == "Paper"
                return "#{name} eats #{op.name}", "Win"
        elsif op.name == name
            return "#{name} equals #{name}", "Tie"
        elsif op.name == "Scissors"
            return "#{op.name} decapitate #{name}", "Lose"
        elsif op.name == "Rock"
            return "#{op.name} crushes #{name}", "Lose"
        end
    end
end

$moves = [Rock.new(name = "Rock"), Paper.new(name = "Paper"), Scissors.new(name = "Scissors"), Lizard.new(name = "Lizard"), Spock.new(name = "Spock")]
