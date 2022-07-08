require 'yaml'

CARD_NAMES = ["Ace",
              "Two",
              "Three",
              "Four",
              "Five",
              "Six",
              "Seven",
              "Eight",
              "Nine",
              "Ten",
              "Jack",
              "Queen",
              "King"]

CARD_SUITES = ["Clubs",    # black
               "Diamonds", # red
               "Spades",   # black
               "Hearts"]   # red

#            Ace, 2, 3, 4, 5, 6, 7, 8, 9, 10,  J,  Q,  K
CARD_VALUES = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 10, 10, 10]

GFX = YAML.load_file('twentyone_cards.yml')
GFX_TOP = GFX["top"]
GFX_BOTTOM = GFX["bottom"]
GFX_SIDE = GFX["side"][0]
GFX_HEART = GFX["heart"].split(/\n/)
GFX_SPADE = GFX["spade"].split(/\n/)
GFX_DIAMOND = GFX["diamond"].split(/\n/)
GFX_CLUB = GFX["club"].split(/\n/)
GFX_UNKNOWN = GFX["unknown"].split(/\n/)
GFX_SUITES = [GFX_CLUB, GFX_DIAMOND, GFX_SPADE, GFX_HEART, GFX_UNKNOWN]
GFX_ID = ["A", "2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K", " "]

def prompt(msg)
  puts "=> #{msg}"
end

def new_deck
  (0..51).to_a
end

def parse_card(card_num)
  card_name_id = card_num % 13
  card_suite_id = card_num / 13
  { name_id: card_name_id, suite_id: card_suite_id }
end

def get_card_name(card_num)
  card = parse_card(card_num)
  "#{CARD_NAMES[card[:name_id]]} of #{CARD_SUITES[card[:suite_id]]}"
end

def get_card_value(card_num)
  card = parse_card(card_num)
  CARD_VALUES[card[:name_id]]
end

def draw_card!(deck, hand)
  hand << deck.slice!(0)
end

# forgot to shuffle the deck?
def draw_card_random!(deck, hand)
  card = (0..deck.length - 1).to_a.sample
  hand << deck.slice!(card)
end

def new_hand(deck)
  hand = []
  2.times { draw_card!(deck, hand) }
  hand
end

def hand_card_values(hand)
  card_values = []
  hand.each do |card|
    card_value = get_card_value(card)
    if card_value == 1 && card_values.sum + 11 <= 21
      card_value = 11
    end
    card_values << card_value
  end
  card_values
end

def clear_screen
  system("clear")
end

def display_hand_gfx_card_symbols(hand, is_dealer_hand = false)
  hand.each_with_index do |card, index|
    card_id = if is_dealer_hand && index > 0
                13
              else
                parse_card(card)[:name_id]
              end
    card_gfx = GFX_ID[card_id]
    print GFX_SIDE
    if card_id == 9
      print "#{card_gfx}    #{card_gfx}#{GFX_SIDE} "
    else
      print " #{card_gfx}    #{card_gfx} #{GFX_SIDE} "
    end
  end
  puts
end

def display_hand_gfx_set_symbols(hand, is_dealer_hand = false)
  (0..6).each do |vert_slice|
    (0..hand.length - 1).each do |card_index|
      card_set_id = if is_dealer_hand && card_index > 0
                      4
                    else
                      parse_card(hand[card_index])[:suite_id]
                    end
      print GFX_SUITES[card_set_id][vert_slice] + " "
    end
    puts
  end
end

def display_hand_gfx(hand, is_dealer_hand = false)
  hand.length.times { print "#{GFX_TOP} " }
  puts
  display_hand_gfx_card_symbols(hand, is_dealer_hand)
  display_hand_gfx_set_symbols(hand, is_dealer_hand)
  display_hand_gfx_card_symbols(hand, is_dealer_hand)
  hand.length.times { print "#{GFX_BOTTOM} " }
  puts "\n\n"
end

def dealer_turn!(deck, dealer_hand)
  while hand_card_values(dealer_hand).sum < 17
    draw_card!(deck, dealer_hand)
  end
end

def player_turn!(deck, dealer_hand, player_hand)
  loop do
    clear_screen
    puts "Dealer's Hand:"
    display_hand_gfx(dealer_hand, true)
    puts "Player's Hand:"
    display_hand_gfx(player_hand, false)
    score = hand_card_values(player_hand).sum
    puts "\n Total Score: #{score}"
    break if score >= 21
    puts "Draw? (type anything starting with 'n/N' for no)"
    ans = gets.chomp[0].downcase
    break if ans == 'n'
    draw_card!(deck, player_hand)
  end
end

def busted?(score)
  score > 21
end

def game_round_outcome(dealer_hand, player_hand)
  player_score = hand_card_values(player_hand).sum
  dealer_score = hand_card_values(dealer_hand).sum
  if busted?(player_score)
    if busted?(dealer_score)
      "You both busted!"
    else
      "You busted! The dealer won!"
    end
  elsif busted?(dealer_score)
    "The dealer busted! You won!"
  elsif player_score > dealer_score
    "You won!"
  elsif player_score < dealer_score
    "The dealer won!"
  else
    "A tie!"
  end
end

def do_game_turns (deck, dealer_hand, player_hand)
  dealer_turn!(deck, dealer_hand)
  player_turn!(deck, dealer_hand, player_hand)
end

def display_game_summary(dealer_hand, player_hand)
  puts "Summary of game:\nDealer's hand:"
  display_hand_gfx(dealer_hand, false)
  puts "Dealer Score: #{hand_card_values(dealer_hand).sum}\n\nPlayer's hand:"
  display_hand_gfx(player_hand, false)
  puts "Player's Score: #{hand_card_values(player_hand).sum}"
  puts game_round_outcome(dealer_hand, player_hand)
end

def game_round
  deck = new_deck.shuffle
  dealer_hand = new_hand(deck)
  player_hand = new_hand(deck)
  do_game_turns(deck, dealer_hand, player_hand)
  clear_screen
  display_game_summary(dealer_hand, player_hand)
end

def main_display_intro
  prompt "Welcome to Twenty One!"
  prompt "See your friendly neighborhood (wo)manpages"
  prompt "for information how to play (man -l twentyone.1)"
  prompt "Or read through 'twentyone.1.md' for the same information."
  prompt "It is in plain text and human readable."
  puts
end

def main
  prompt "Would you like to play a round?"
  ans = gets.chomp.downcase[0]
  return if ans != 'y'
  loop do
    game_round
    prompt "Would you like to play another round?"
    prompt "(Type anything starting with 'n/N' for no"
    ans = gets.chomp.downcase[0]
    break if ans != 'y'
  end
end

main
