PLAYER_MARK = 'X'
AI_MARK = 'O'
ROWS = [[1, 2, 3],
        [4, 5, 6],
        [7, 8, 9],
        [1, 4, 7],
        [2, 5, 8],
        [3, 6, 9],
        [1, 5, 9],
        [3, 5, 7]]

def joinor(list, sep=', ', lastword='or')
  list[-1] = "#{lastword} #{list[-1]}"
  list.join(sep)
end

def prompt(msg)
  puts "=> #{msg}"
end

def init_empty_board
  board = {}
  (1..9).each do |n|
    board[n] = ' '
  end
  board
end

# rubocop:disable Metrics/AbcSize
def display_board(brd)
  puts "1    |2    |3    "
  puts "  #{brd[1]}  |  #{brd[2]}  |  #{brd[3]}  "
  puts "     |     |     "
  puts "-----+-----+-----"
  puts "4    |5    |6    "
  puts "  #{brd[4]}  |  #{brd[5]}  |  #{brd[6]}  "
  puts "     |     |     "
  puts "-----+-----+-----"
  puts "7    |8    |9    "
  puts "  #{brd[7]}  |  #{brd[8]}  |  #{brd[9]}  "
  puts "     |     |     "
end

def display_board_fancy(brd)
  puts "¹    |²    |³    "
  puts "  #{brd[1]}  |  #{brd[2]}  |  #{brd[3]}  "
  puts "     |     |     "
  puts "-----+-----+-----"
  puts "⁴    |⁵    |⁶    "
  puts "  #{brd[4]}  |  #{brd[5]}  |  #{brd[6]}  "
  puts "     |     |     "
  puts "-----+-----+-----"
  puts "⁷    |⁸    |⁹    "
  puts "  #{brd[7]}  |  #{brd[8]}  |  #{brd[9]}  "
  puts "     |     |     "
end
# rubocop:enable Metrics/AbcSize

def empty_squares(brd)
  brd.select { |_k, v| v == ' ' }.keys
end

def player_turn!(brd)
  loop do
    prompt "Choose a square (1-9):"
    chosen = gets.chomp.to_i
    if !(1..9).include?(chosen) || brd[chosen] != ' '
      prompt "Invalid selection."
      prompt "Consider reading the tictactoe manpage (man -l tictactoe.1)"
    else
      brd[chosen] = PLAYER_MARK
      break
    end
  end
end

def computer_turn!(brd)
  chosen = ai_offensive_choice(brd, 2)
  chosen ||= ai_defensive_choice(brd, 2)
  chosen ||= ai_offensive_choice(brd, 1)
  chosen ||= ai_defensive_choice(brd, 1)
  chosen ||= ai_random_choice(brd)
  brd[chosen] = AI_MARK
end

def ai_random_choice(brd)
  empty_squares(brd).sample
end

# Prevent the human from completing their third square.
# If the opponent does not have 2 out of 3 in a row, then
# place a mark to prevent the row from being utilized by
# the opponent. If there are no rows where only a human
# mark is in the row, then return false.
def ai_defensive_choice(brd, level)
  ROWS.each do |row|
    if row_mark_count(brd, row, PLAYER_MARK) == level
      return row.select { |e| brd[e] == ' ' }.sample
    end
  end
  false
end

# Seek out a row where the AI has 2 out of 3 marks in a
# row and complete it. If there are none, then seek out
# where the AI has 1 out of 3 and place a second one. If
# there are none, then return false.
def ai_offensive_choice(brd, level)
  return 5 if level == 1 && brd[5] == ' '
  ROWS.each do |row|
    if row_mark_count(brd, row, AI_MARK) == level
      return row.select { |e| brd[e] == ' ' }.sample
    end
  end
  false
end

# For a given row, returns the number of a certain player
# mark in the row. If it contains an opposing player mark,
# returns false instead of the amount.
# row is a 3-element array containing the squares in the row
def row_mark_count(brd, row, mark)
  count = 0
  row.each do |square|
    if brd[square] == mark
      count += 1
    elsif brd[square] != ' '
      return false
    end
  end
  count
end

def check_if_winner(brd, mark)
  ROWS.each do |row|
    return true if row_mark_count(brd, row, mark) == 3
  end
  false
end

def board_full?(brd)
  empty_squares(brd) == []
end

# rubocop:disable Metrics/MethodLength
def game_round(board)
  terminal_condition = ''
  loop do
    display_board_fancy(board)

    player_turn!(board)
    if check_if_winner(board, PLAYER_MARK)
      terminal_condition = "player"
      break
    elsif board_full?(board)
      terminal_condition = "tie"
      break
    end

    computer_turn!(board)
    if check_if_winner(board, AI_MARK)
      terminal_condition = "computer"
      break
    elsif board_full?(board)
      terminal_condition = "tie"
      break
    end
  end

  display_board_fancy(board)
  terminal_condition
end
# rubocop:enable Metrics/MethodLength

# return false if we don't have a winner.
# If we do have a winner, return a string consisting
# of either "Player" or "Computer"
def check_overall_winner(rounds, plr_wins, cmp_wins)
  if plr_wins + cmp_wins < rounds || plr_wins == cmp_wins
    false
  else
    plr_wins > cmp_wins ? "Player" : "Computer"
  end
end

# Gameplay loop
# rubocop:disable Metrics/MethodLength
# rubocop:disable Metrics/AbcSize
def game_tournament(rounds = 5)
  plr_wins = cmp_wins = 0

  loop do
    board = init_empty_board
    prompt "Welcome to Tic Tac Toe"
    prompt "See manpages for how to play (man -l tictactoe.1)"
    terminal_condition = game_round(board)
    if terminal_condition == "player"
      prompt "Congratulations, you have won."
      plr_wins += 1
    elsif terminal_condition == "computer"
      prompt "Congratulations, you lost to the AI."
      cmp_wins += 1
    else
      prompt "Alright, we'll call it a draw."
    end

    winner = check_overall_winner(rounds, plr_wins, cmp_wins)

    if !winner
      prompt "Play again?"
      repeat = gets.chomp.downcase
      if repeat != 'y'
        break
      end
    else
      puts "The #{winner} wins the #{rounds} rounds!"
      break
    end
  end # end of loop
end
# rubocop:enable Metrics/MethodLength
# rubocop:enable Metrics/AbcSize

def main
  prompt "Welcome to Tic Tac Toe"
  prompt "How many rounds would you like to play (choose a whole number)?"
  rounds = gets.chomp.to_i
  game_tournament(rounds)
end

main
