# frozen-string-literal: true

# Gameboard including the 3x3 array of tiles and methods to
# evaluate whether there is a winning combination on the board
class GameBoard
  WINNING_COMBOS = [[[0, 0], [0, 1], [0, 2]],
                    [[1, 0], [1, 1], [1, 2]],
                    [[2, 0], [2, 1], [2, 2]],
                    [[0, 0], [1, 0], [2, 0]],
                    [[0, 1], [1, 1], [2, 1]],
                    [[0, 2], [1, 2], [2, 2]],
                    [[0, 0], [1, 1], [2, 2]],
                    [[2, 0], [1, 1], [0, 2]]].freeze
  def initialize
    @game_tiles = Array.new(3) { Array.new(3) }
    @player_turn = 'o'
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
      change_player_turn # @player_turn starts as 'o' such that during the first iteration 'x' goes first
      get_player_input(@player_turn)
      print_board
      win_condition = evaluate_board
    end
    player = @player_turn == 'x' ? 1 : 2
    puts "Congratulations Player #{player}, you've won!"
  end

  def evaluate_board
    WINNING_COMBOS.each do |combination|
      count = 0
      combination.each do |coordinate|
        @game_tiles[coordinate[0]][coordinate[1]].tile_state == @player_turn ? count += 1 : 0
      end
      return true if count == 3
    end
    false
  end

  def change_player_turn
    @player_turn = if @player_turn == 'x'
                     'o'
                   else
                     'x'
                   end
  end

  def get_player_input(state)
    player = state == 'x' ? 1 : 2
    puts "Player #{player}: Enter your row input '#{state}'"
    play_one_row = gets.to_i
    puts "Player #{player}: Enter your column input '#{state}'"
    play_one_column = gets.to_i
    change_tile(play_one_row, play_one_column, state) if play_one_row.between?(0, 2) && play_one_column.between?(0, 2)
  end
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
test_board.game_loop
