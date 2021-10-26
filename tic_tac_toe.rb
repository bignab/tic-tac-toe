# frozen-string-literal: true

# Gameboard including the 3x3 array of tiles and methods to
# evaluate whether there is a winning combination on the board
class GameBoard
  def initialize
    @game_tiles = Array.new(3) { Array.new(3) }
    @game_tiles.each_with_index do |row, row_index|
      row.each_with_index do |_, column_index|
        @game_tiles[row_index][column_index] = GameTile.new(row_index, column_index)
      end
    end
  end

  def print_board
    puts "#{@game_tiles[0][0].tile_state} | #{@game_tiles[0][1].tile_state} | #{@game_tiles[0][2].tile_state}"
    puts '_________'
    puts "#{@game_tiles[1][0].tile_state} | #{@game_tiles[1][1].tile_state} | #{@game_tiles[1][2].tile_state}"
    puts '_________'
    puts "#{@game_tiles[2][0].tile_state} | #{@game_tiles[2][1].tile_state} | #{@game_tiles[2][2].tile_state}"
  end

  def change_tile(row, column, state)
    @game_tiles[row][column].change_state(state)
  end

  def game_loop
    win_condition = false
    until win_condition
      print_board
      
      # evaluate_board
      puts "Player 2: Enter your row input 'x'"
      play_two_row = gets
      puts "Player 2: Enter your column input 'x'"
      play_two_column = gets
      change_tile(play_two_row, play_two_column, 'x') if play_two_row.between?(0, 2) && play_two_column.between?(0, 2)
      win_condition = true
    end
  end
end

def get_player_input(state)
  puts "Player 1: Enter your row input '#{state}'"
  play_one_row = gets
  puts "Player 1: Enter your column input '#{state}'"
  play_one_column = gets
  change_tile(play_one_row, play_one_column, 'x') if play_one_row.between?(0, 2) && play_one_column.between?(0, 2)
end

# Class representing each of the nine game tiles in tic-tac-toe, with position_x and position_y
# representing the coordinates of the individual GameTiles on the GameBoard
class GameTile
  attr_reader :tile_state

  def initialize(position_x, position_y)
    @position_x = position_x
    @position_y = position_y
    @tile_state = ''
  end

  def change_state(x_or_o)
    valid_inputs = %w[x o]
    if valid_inputs.include?(x_or_o)
      @tile_state = x_or_o
    else
      'Invalid input'
    end
  end
  @tile_state
end

test_board = GameBoard.new
p test_board.print_board
