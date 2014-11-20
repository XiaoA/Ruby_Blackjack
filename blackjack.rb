# Game Logic

# Decks: Will I need more than one deck?

# I'll need:
# - At least one deck (A - K, four suits)
# - A way to keep track of the user's name
# - A way to keep track of all cards available and in use
# - A way to force the dealer to deal at least to 17
# - A way to set 21 as the winning hand, and a way to handle 'busts'
# - A loop that allows the player to continue to play until he/she wants to quit
# - A way to keep track of bets and money
# - A way to 'shuffle' the deck

# Implementation
# Array vs. Hash for the cards
# Using randomization                  

# Bonus Features
# - Burning cards
# - doubling down
# - insurance bets
# - splitting


# Procedural Blackboard Game, written in Ruby
require 'pry'

deck_one = { 'one_of_hearts' => 1, 'two_of_hearts' =>  2, 'three_of_hearts' => 3, 'four_of_hearts' =>  4, 'five_of_hearts' =>  5, 'six_of_hearts' =>  6, 'seven_of_hearts' =>  7, 'eight_of_hearts' =>  8, 'nine_of_hearts' =>  9, 'ten_of_hearts' =>  10, 'jack_of_hearts' =>  10, 'queen_of_hearts' => 10, 'king_of_hearts' => 10, 'ace_of_hearts' => 11, 'one_of_clubs' => 1, 'two_of_clubs' =>  2, 'three_of_clubs' => 3, 'four_of_clubs' =>  4, 'five_of_clubs' =>  5, 'six_of_clubs' =>  6, 'seven_of_clubs' =>  7, 'eight_of_clubs' =>  8, 'nine_of_clubs' =>  9, 'ten_of_clubs' =>  10, 'jack_of_clubs' =>  10, 'queen_of_clubs' => 10, 'king_of_clubs' => 10, 'ace_of_clubs' => 11, 'one_of_spades' => 1, 'two_of_spades' =>  2, 'three_of_spades' => 3, 'four_of_spades' =>  4, 'five_of_spades' =>  5, 'six_of_spades' =>  6, 'seven_of_spades' =>  7, 'eight_of_spades' =>  8, 'nine_of_spades' =>  9, 'ten_of_spades' =>  10, 'jack_of_spades' =>  10, 'queen_of_spades' => 10, 'king_of_spades' => 10, 'ace_of_spades' => 11, 'one_of_diamonds' => 1, 'two_of_diamonds' =>  2, 'three_of_diamonds' => 3, 'four_of_diamonds' =>  4, 'five_of_diamonds' =>  5, 'six_of_diamonds' =>  6, 'seven_of_diamonds' =>  7, 'eight_of_diamonds' =>  8, 'nine_of_diamonds' =>  9, 'ten_of_diamonds' =>  10, 'jack_of_diamonds' =>  10, 'queen_of_diamonds' => 10, 'king_of_diamonds' => 10, 'ace_of_diamonds' => 11 }

deck_two = { 'one_of_hearts' => 1, 'two_of_hearts' =>  2, 'three_of_hearts' => 3, 'four_of_hearts' =>  4, 'five_of_hearts' =>  5, 'six_of_hearts' =>  6, 'seven_of_hearts' =>  7, 'eight_of_hearts' =>  8, 'nine_of_hearts' =>  9, 'ten_of_hearts' =>  10, 'jack_of_hearts' =>  10, 'queen_of_hearts' => 10, 'king_of_hearts' => 10, 'ace_of_hearts' => 11, 'one_of_clubs' => 1, 'two_of_clubs' =>  2, 'three_of_clubs' => 3, 'four_of_clubs' =>  4, 'five_of_clubs' =>  5, 'six_of_clubs' =>  6, 'seven_of_clubs' =>  7, 'eight_of_clubs' =>  8, 'nine_of_clubs' =>  9, 'ten_of_clubs' =>  10, 'jack_of_clubs' =>  10, 'queen_of_clubs' => 10, 'king_of_clubs' => 10, 'ace_of_clubs' => 11, 'one_of_spades' => 1, 'two_of_spades' =>  2, 'three_of_spades' => 3, 'four_of_spades' =>  4, 'five_of_spades' =>  5, 'six_of_spades' =>  6, 'seven_of_spades' =>  7, 'eight_of_spades' =>  8, 'nine_of_spades' =>  9, 'ten_of_spades' =>  10, 'jack_of_spades' =>  10, 'queen_of_spades' => 10, 'king_of_spades' => 10, 'ace_of_spades' => 11, 'one_of_diamonds' => 1, 'two_of_diamonds' =>  2, 'three_of_diamonds' => 3, 'four_of_diamonds' =>  4, 'five_of_diamonds' =>  5, 'six_of_diamonds' =>  6, 'seven_of_diamonds' =>  7, 'eight_of_diamonds' =>  8, 'nine_of_diamonds' =>  9, 'ten_of_diamonds' =>  10, 'jack_of_diamonds' =>  10, 'queen_of_diamonds' => 10, 'king_of_diamonds' => 10, 'ace_of_diamonds' => 11 }

deck_three = { 'one_of_hearts' => 1, 'two_of_hearts' =>  2, 'three_of_hearts' => 3, 'four_of_hearts' =>  4, 'five_of_hearts' =>  5, 'six_of_hearts' =>  6, 'seven_of_hearts' =>  7, 'eight_of_hearts' =>  8, 'nine_of_hearts' =>  9, 'ten_of_hearts' =>  10, 'jack_of_hearts' =>  10, 'queen_of_hearts' => 10, 'king_of_hearts' => 10, 'ace_of_hearts' => 11, 'one_of_clubs' => 1, 'two_of_clubs' =>  2, 'three_of_clubs' => 3, 'four_of_clubs' =>  4, 'five_of_clubs' =>  5, 'six_of_clubs' =>  6, 'seven_of_clubs' =>  7, 'eight_of_clubs' =>  8, 'nine_of_clubs' =>  9, 'ten_of_clubs' =>  10, 'jack_of_clubs' =>  10, 'queen_of_clubs' => 10, 'king_of_clubs' => 10, 'ace_of_clubs' => 11, 'one_of_spades' => 1, 'two_of_spades' =>  2, 'three_of_spades' => 3, 'four_of_spades' =>  4, 'five_of_spades' =>  5, 'six_of_spades' =>  6, 'seven_of_spades' =>  7, 'eight_of_spades' =>  8, 'nine_of_spades' =>  9, 'ten_of_spades' =>  10, 'jack_of_spades' =>  10, 'queen_of_spades' => 10, 'king_of_spades' => 10, 'ace_of_spades' => 11, 'one_of_diamonds' => 1, 'two_of_diamonds' =>  2, 'three_of_diamonds' => 3, 'four_of_diamonds' =>  4, 'five_of_diamonds' =>  5, 'six_of_diamonds' =>  6, 'seven_of_diamonds' =>  7, 'eight_of_diamonds' =>  8, 'nine_of_diamonds' =>  9, 'ten_of_diamonds' =>  10, 'jack_of_diamonds' =>  10, 'queen_of_diamonds' => 10, 'king_of_diamonds' => 10, 'ace_of_diamonds' => 11 }

deck_four = { 'one_of_hearts' => 1, 'two_of_hearts' =>  2, 'three_of_hearts' => 3, 'four_of_hearts' =>  4, 'five_of_hearts' =>  5, 'six_of_hearts' =>  6, 'seven_of_hearts' =>  7, 'eight_of_hearts' =>  8, 'nine_of_hearts' =>  9, 'ten_of_hearts' =>  10, 'jack_of_hearts' =>  10, 'queen_of_hearts' => 10, 'king_of_hearts' => 10, 'ace_of_hearts' => 11, 'one_of_clubs' => 1, 'two_of_clubs' =>  2, 'three_of_clubs' => 3, 'four_of_clubs' =>  4, 'five_of_clubs' =>  5, 'six_of_clubs' =>  6, 'seven_of_clubs' =>  7, 'eight_of_clubs' =>  8, 'nine_of_clubs' =>  9, 'ten_of_clubs' =>  10, 'jack_of_clubs' =>  10, 'queen_of_clubs' => 10, 'king_of_clubs' => 10, 'ace_of_clubs' => 11, 'one_of_spades' => 1, 'two_of_spades' =>  2, 'three_of_spades' => 3, 'four_of_spades' =>  4, 'five_of_spades' =>  5, 'six_of_spades' =>  6, 'seven_of_spades' =>  7, 'eight_of_spades' =>  8, 'nine_of_spades' =>  9, 'ten_of_spades' =>  10, 'jack_of_spades' =>  10, 'queen_of_spades' => 10, 'king_of_spades' => 10, 'ace_of_spades' => 11, 'one_of_diamonds' => 1, 'two_of_diamonds' =>  2, 'three_of_diamonds' => 3, 'four_of_diamonds' =>  4, 'five_of_diamonds' =>  5, 'six_of_diamonds' =>  6, 'seven_of_diamonds' =>  7, 'eight_of_diamonds' =>  8, 'nine_of_diamonds' =>  9, 'ten_of_diamonds' =>  10, 'jack_of_diamonds' =>  10, 'queen_of_diamonds' => 10, 'king_of_diamonds' => 10, 'ace_of_diamonds' => 11 }

shoe = [deck_one, deck_two, deck_three, deck_four]

