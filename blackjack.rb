# Game Logic

# Decks: Will I need more than one deck?

# I'll need:
# - At least one deck (A - K, four suits)
# - A way to keep track of the user's name
# - A way to keep track of all cards available and in use
# - A way to force the dealer to deal at least to 17
# - A way to set 21 as the winning hand, and a way to handle 'busts'
# - A loop that allows the player to continue to play until he/she wants to quit
# - A way to keep track of bets, and money.
# - A way to 'shuffle' the deck
# - A way to deal cards to the dealer, so that the top card is visible, but the bottom card is hidden. (I'll then need to check the dealer's total. If less than 17 the deal has to hit; if 21, deal hit Blackjack; if > 21, dealer busts.)

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

def say(msg)
  puts "=> #{msg}"
end

deck_one = { 'two_of_hearts' =>  2, 'three_of_hearts' => 3, 'four_of_hearts' =>  4, 'five_of_hearts' =>  5, 'six_of_hearts' =>  6, 'seven_of_hearts' =>  7, 'eight_of_hearts' =>  8, 'nine_of_hearts' =>  9, 'ten_of_hearts' =>  10, 'jack_of_hearts' =>  10, 'queen_of_hearts' => 10, 'king_of_hearts' => 10, 'ace_of_hearts' => 11, 'two_of_clubs' =>  2, 'three_of_clubs' => 3, 'four_of_clubs' =>  4, 'five_of_clubs' =>  5, 'six_of_clubs' =>  6, 'seven_of_clubs' =>  7, 'eight_of_clubs' =>  8, 'nine_of_clubs' =>  9, 'ten_of_clubs' =>  10, 'jack_of_clubs' =>  10, 'queen_of_clubs' => 10, 'king_of_clubs' => 10, 'ace_of_clubs' => 11, 'two_of_spades' =>  2, 'three_of_spades' => 3, 'four_of_spades' =>  4, 'five_of_spades' =>  5, 'six_of_spades' =>  6, 'seven_of_spades' =>  7, 'eight_of_spades' =>  8, 'nine_of_spades' =>  9, 'ten_of_spades' =>  10, 'jack_of_spades' =>  10, 'queen_of_spades' => 10, 'king_of_spades' => 10, 'ace_of_spades' => 11, 'two_of_diamonds' =>  2, 'three_of_diamonds' => 3, 'four_of_diamonds' =>  4, 'five_of_diamonds' =>  5, 'six_of_diamonds' =>  6, 'seven_of_diamonds' =>  7, 'eight_of_diamonds' =>  8, 'nine_of_diamonds' =>  9, 'ten_of_diamonds' =>  10, 'jack_of_diamonds' =>  10, 'queen_of_diamonds' => 10, 'king_of_diamonds' => 10, 'ace_of_diamonds' => 11 }

deck_two = { 'two_of_hearts' =>  2, 'three_of_hearts' => 3, 'four_of_hearts' =>  4, 'five_of_hearts' =>  5, 'six_of_hearts' =>  6, 'seven_of_hearts' =>  7, 'eight_of_hearts' =>  8, 'nine_of_hearts' =>  9, 'ten_of_hearts' =>  10, 'jack_of_hearts' =>  10, 'queen_of_hearts' => 10, 'king_of_hearts' => 10, 'ace_of_hearts' => 11, 'two_of_clubs' =>  2, 'three_of_clubs' => 3, 'four_of_clubs' =>  4, 'five_of_clubs' =>  5, 'six_of_clubs' =>  6, 'seven_of_clubs' =>  7, 'eight_of_clubs' =>  8, 'nine_of_clubs' =>  9, 'ten_of_clubs' =>  10, 'jack_of_clubs' =>  10, 'queen_of_clubs' => 10, 'king_of_clubs' => 10, 'ace_of_clubs' => 11, 'two_of_spades' =>  2, 'three_of_spades' => 3, 'four_of_spades' =>  4, 'five_of_spades' =>  5, 'six_of_spades' =>  6, 'seven_of_spades' =>  7, 'eight_of_spades' =>  8, 'nine_of_spades' =>  9, 'ten_of_spades' =>  10, 'jack_of_spades' =>  10, 'queen_of_spades' => 10, 'king_of_spades' => 10, 'ace_of_spades' => 11, 'two_of_diamonds' =>  2, 'three_of_diamonds' => 3, 'four_of_diamonds' =>  4, 'five_of_diamonds' =>  5, 'six_of_diamonds' =>  6, 'seven_of_diamonds' =>  7, 'eight_of_diamonds' =>  8, 'nine_of_diamonds' =>  9, 'ten_of_diamonds' =>  10, 'jack_of_diamonds' =>  10, 'queen_of_diamonds' => 10, 'king_of_diamonds' => 10, 'ace_of_diamonds' => 11 }

deck_three = { 'two_of_hearts' =>  2, 'three_of_hearts' => 3, 'four_of_hearts' =>  4, 'five_of_hearts' =>  5, 'six_of_hearts' =>  6, 'seven_of_hearts' =>  7, 'eight_of_hearts' =>  8, 'nine_of_hearts' =>  9, 'ten_of_hearts' =>  10, 'jack_of_hearts' =>  10, 'queen_of_hearts' => 10, 'king_of_hearts' => 10, 'ace_of_hearts' => 11, 'two_of_clubs' =>  2, 'three_of_clubs' => 3, 'four_of_clubs' =>  4, 'five_of_clubs' =>  5, 'six_of_clubs' =>  6, 'seven_of_clubs' =>  7, 'eight_of_clubs' =>  8, 'nine_of_clubs' =>  9, 'ten_of_clubs' =>  10, 'jack_of_clubs' =>  10, 'queen_of_clubs' => 10, 'king_of_clubs' => 10, 'ace_of_clubs' => 11, 'two_of_spades' =>  2, 'three_of_spades' => 3, 'four_of_spades' =>  4, 'five_of_spades' =>  5, 'six_of_spades' =>  6, 'seven_of_spades' =>  7, 'eight_of_spades' =>  8, 'nine_of_spades' =>  9, 'ten_of_spades' =>  10, 'jack_of_spades' =>  10, 'queen_of_spades' => 10, 'king_of_spades' => 10, 'ace_of_spades' => 11, 'two_of_diamonds' =>  2, 'three_of_diamonds' => 3, 'four_of_diamonds' =>  4, 'five_of_diamonds' =>  5, 'six_of_diamonds' =>  6, 'seven_of_diamonds' =>  7, 'eight_of_diamonds' =>  8, 'nine_of_diamonds' =>  9, 'ten_of_diamonds' =>  10, 'jack_of_diamonds' =>  10, 'queen_of_diamonds' => 10, 'king_of_diamonds' => 10, 'ace_of_diamonds' => 11 }

deck_four = { 'two_of_hearts' =>  2, 'three_of_hearts' => 3, 'four_of_hearts' =>  4, 'five_of_hearts' =>  5, 'six_of_hearts' =>  6, 'seven_of_hearts' =>  7, 'eight_of_hearts' =>  8, 'nine_of_hearts' =>  9, 'ten_of_hearts' =>  10, 'jack_of_hearts' =>  10, 'queen_of_hearts' => 10, 'king_of_hearts' => 10, 'ace_of_hearts' => 11, 'two_of_clubs' =>  2, 'three_of_clubs' => 3, 'four_of_clubs' =>  4, 'five_of_clubs' =>  5, 'six_of_clubs' =>  6, 'seven_of_clubs' =>  7, 'eight_of_clubs' =>  8, 'nine_of_clubs' =>  9, 'ten_of_clubs' =>  10, 'jack_of_clubs' =>  10, 'queen_of_clubs' => 10, 'king_of_clubs' => 10, 'ace_of_clubs' => 11, 'two_of_spades' =>  2, 'three_of_spades' => 3, 'four_of_spades' =>  4, 'five_of_spades' =>  5, 'six_of_spades' =>  6, 'seven_of_spades' =>  7, 'eight_of_spades' =>  8, 'nine_of_spades' =>  9, 'ten_of_spades' =>  10, 'jack_of_spades' =>  10, 'queen_of_spades' => 10, 'king_of_spades' => 10, 'ace_of_spades' => 11, 'two_of_diamonds' =>  2, 'three_of_diamonds' => 3, 'four_of_diamonds' =>  4, 'five_of_diamonds' =>  5, 'six_of_diamonds' =>  6, 'seven_of_diamonds' =>  7, 'eight_of_diamonds' =>  8, 'nine_of_diamonds' =>  9, 'ten_of_diamonds' =>  10, 'jack_of_diamonds' =>  10, 'queen_of_diamonds' => 10, 'king_of_diamonds' => 10, 'ace_of_diamonds' => 11 }

shoe = [deck_one.to_a.shuffle!, deck_two.to_a.shuffle!, deck_three.to_a.shuffle!, deck_four.to_a.shuffle!]

burn_card_stack = []
dealer_hand = []
player_hand = []

burn_card_stack << shoe.pop.pop
dealer_hand << shoe.pop.pop
player_hand << shoe.pop.pop
dealer_hand << shoe.pop.pop


def hit(shoe)
  deal_player_card(shoe)
end



#def check_for_winner


puts "Welcome to Blackjack!"
puts "The #{burn_card_stack[0][0]} card has been burned!"
puts "Dealer has a  #{dealer_hand[0][0]}"
puts "You have a #{player_hand[0][0]}"
say "Do you want to Hit or Stand? (Type '1' to Hit, and '2' to Stand)"
hit_or_stand = gets.chomp.to_s









