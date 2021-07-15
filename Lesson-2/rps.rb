VALID_CHOICES = %w(rock paper scissors spock lizard)

def test_method
  prompt("test")
end

def prompt(message)
  Kernel.puts("=> #{message}")
end

test_method

def result(player_choice, computer_choice)
  case player_choice
  when 'rock'
    case computer_choice
    when 'scissors' then 'win'
    when 'paper' then 'lose'
    end
  when 'paper'
    case computer_choice
    when 'rock' then 'win'
    when 'scissors' then 'lose'
    end
  when 'scissors'
    case computer_choice
    when 'paper' then 'win'
    when 'rock' then 'lose'
    end
  end
  'tie'
end

def result2(player_choice, computer_choice)
  win = { 'rock' => 'scissors',
          'paper' => 'rock',
          'scissors' => 'paper' }
  lose = { 'rock' => 'paper',
           'paper' => 'scissors',
           'scissors' => 'rock' }
  if win[player_choice] == computer_choice
    'win'
  elsif lose[player_choice] == computer_choice
    'lose'
  else
    'tie'
  end
end

def result3(player_choice, computer_choice)
  win = { 'rock' => 'scissors',
          'paper' => 'rock',
          'scissors' => 'paper' }
  if win[player_choice] == computer_choice
    'win'
  elsif player_choice == computer_choice
    'tie'
  else
    'lose'
  end
end

def result_spock_lizard(player_choice, computer_choice)
  win = { 'rock' => %w(scissors lizard),
          'paper' => %w(rock spock),
          'scissors' => %w(paper lizard),
          'spock' => %w(rock scissors),
          'lizard' => %w(spock paper) }
  if win[player_choice].include?(computer_choice)
    'win'
  elsif player_choice == computer_choice
    'tie'
  else
    'lose'
  end
end

def parse_choice(choice)
  possibilities = []
  VALID_CHOICES.each do |word|
    if word.start_with?(choice)
      possibilities << word
    end
  end
  return 'invalid' if possibilities.size != 1
  possibilities[0]
end

# main game loop
score_player = 0
score_computer = 0
score_ties = 0
loop do
  # player decision validation loop
  player_choice = ''
  loop do
    prompt("Choose one: #{VALID_CHOICES.join(', ')}")
    prompt("You may type the first letter or first two letters.")
    response = Kernel.gets().chomp()
    player_choice = parse_choice(response)

    if VALID_CHOICES.include?(player_choice)
      break
    else
      prompt("That's not a valid choice.")
    end
  end

  computer_choice = VALID_CHOICES.sample()

  # determine and display results
  prompt("You chose #{player_choice}, the computer chose #{computer_choice}.")
  case result_spock_lizard(player_choice, computer_choice)
  when 'win'
    prompt("You won!")
    score_player += 1
  when 'lose'
    prompt("The computer won!")
    score_computer += 1
  else
    prompt("A tie!")
    score_ties += 1
  end

  prompt("Do you want to play again? (Y/n)")
  play_again = Kernel.gets().chomp()
  break unless play_again.downcase.start_with?('y')
end

prompt("Scores for this session:")
prompt("------------------------")
prompt("Player wins:   #{score_player}")
prompt("Computer wins: #{score_computer}")
prompt("Ties:          #{score_ties}")
