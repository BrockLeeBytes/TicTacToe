module TicTacToe

	class Player

		attr_accessor :name, :sym, :list
		
		def initialize(name, sym, list=Array.new)
			@name = name
			@sym = sym
			@list = list
		end
	end

	class Board

		attr_accessor :grid
		
		def initialize
		    grid
		end

		def grid 
			@grid = (1..9).to_a
		end

		def draw_grid
			puts "\n"
			@grid.each_slice(3) {|row| puts row.join(" | ")}
			puts "\n"
		end

		def update_board(answer, p_sym)
			@grid[answer.to_i - 1] = p_sym
		end

	end

	class Game
		
		def initialize
			@board = Board.new
			@win = WinCondition.new
			game_script
		end

		def turn
			if @turn % 2 == 0
				puts "#{@player_2.name} pick a number to place your symbol"
				answer = gets.chomp
				@board.update_board(answer, @player_2.sym)
				@player_2.list.push(answer.to_i)
			else
				puts "#{@player_1.name} pick a number to place your symbol"
				answer = gets.chomp
				@board.update_board(answer, @player_1.sym)
				@player_1.list.push(answer.to_i)
			end
		end

		def player_init
			puts "Player 1 enter your name:"
			@player_1 = Player.new(gets.chomp, "X")
			puts "Player 2 enter your name:"
			@player_2 = Player.new(gets.chomp, "O")
		end

		def game_script
			@turn = 1
			player_init
			while @turn < 10
				@board.draw_grid
				turn
				if @win.win?(@player_1.list) == true
				    puts "Congrats, #{@player_1.name}, you win!"
				    break
				elsif @win.win?(@player_2.list) == true
				    puts "Congrats, #{@player_2.name}, you win!"
				    break
				end
				    
				@turn +=1
			end
			puts "Sorry, guys. It's a draw."
		end

	end

	class WinCondition
		@@win_cond = [[1,2,3],[4,5,6],[7,8,9],[1,4,7],[2,5,8],[3,6,9],[3,5,7],[1,5,9]]
		
		def win?(player_list)
			@@win_cond.each do |win_combo|
				if win_combo.all? {|n| player_list.include? n}
					return true
				end
			end
		end

	end

end