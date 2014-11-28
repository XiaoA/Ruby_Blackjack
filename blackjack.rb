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

# def check_for_winner

deck_one = { 'two_of_hearts' =>  2, 'three_of_hearts' => 3, 'four_of_hearts' =>  4, 'five_of_hearts' =>  5, 'six_of_hearts' =>  6, 'seven_of_hearts' =>  7, 'eight_of_hearts' =>  8, 'nine_of_hearts' =>  9, 'ten_of_hearts' =>  10, 'jack_of_hearts' =>  10, 'queen_of_hearts' => 10, 'king_of_hearts' => 10, 'ace_of_hearts' => 11, 'two_of_clubs' =>  2, 'three_of_clubs' => 3, 'four_of_clubs' =>  4, 'five_of_clubs' =>  5, 'six_of_clubs' =>  6, 'seven_of_clubs' =>  7, 'eight_of_clubs' =>  8, 'nine_of_clubs' =>  9, 'ten_of_clubs' =>  10, 'jack_of_clubs' =>  10, 'queen_of_clubs' => 10, 'king_of_clubs' => 10, 'ace_of_clubs' => 11, 'two_of_spades' =>  2, 'three_of_spades' => 3, 'four_of_spades' =>  4, 'five_of_spades' =>  5, 'six_of_spades' =>  6, 'seven_of_spades' =>  7, 'eight_of_spades' =>  8, 'nine_of_spades' =>  9, 'ten_of_spades' =>  10, 'jack_of_spades' =>  10, 'queen_of_spades' => 10, 'king_of_spades' => 10, 'ace_of_spades' => 11, 'two_of_diamonds' =>  2, 'three_of_diamonds' => 3, 'four_of_diamonds' =>  4, 'five_of_diamonds' =>  5, 'six_of_diamonds' =>  6, 'seven_of_diamonds' =>  7, 'eight_of_diamonds' =>  8, 'nine_of_diamonds' =>  9, 'ten_of_diamonds' =>  10, 'jack_of_diamonds' =>  10, 'queen_of_diamonds' => 10, 'king_of_diamonds' => 10, 'ace_of_diamonds' => 11 }

deck_two = { 'two_of_hearts' =>  2, 'three_of_hearts' => 3, 'four_of_hearts' =>  4, 'five_of_hearts' =>  5, 'six_of_hearts' =>  6, 'seven_of_hearts' =>  7, 'eight_of_hearts' =>  8, 'nine_of_hearts' =>  9, 'ten_of_hearts' =>  10, 'jack_of_hearts' =>  10, 'queen_of_hearts' => 10, 'king_of_hearts' => 10, 'ace_of_hearts' => 11, 'two_of_clubs' =>  2, 'three_of_clubs' => 3, 'four_of_clubs' =>  4, 'five_of_clubs' =>  5, 'six_of_clubs' =>  6, 'seven_of_clubs' =>  7, 'eight_of_clubs' =>  8, 'nine_of_clubs' =>  9, 'ten_of_clubs' =>  10, 'jack_of_clubs' =>  10, 'queen_of_clubs' => 10, 'king_of_clubs' => 10, 'ace_of_clubs' => 11, 'two_of_spades' =>  2, 'three_of_spades' => 3, 'four_of_spades' =>  4, 'five_of_spades' =>  5, 'six_of_spades' =>  6, 'seven_of_spades' =>  7, 'eight_of_spades' =>  8, 'nine_of_spades' =>  9, 'ten_of_spades' =>  10, 'jack_of_spades' =>  10, 'queen_of_spades' => 10, 'king_of_spades' => 10, 'ace_of_spades' => 11, 'two_of_diamonds' =>  2, 'three_of_diamonds' => 3, 'four_of_diamonds' =>  4, 'five_of_diamonds' =>  5, 'six_of_diamonds' =>  6, 'seven_of_diamonds' =>  7, 'eight_of_diamonds' =>  8, 'nine_of_diamonds' =>  9, 'ten_of_diamonds' =>  10, 'jack_of_diamonds' =>  10, 'queen_of_diamonds' => 10, 'king_of_diamonds' => 10, 'ace_of_diamonds' => 11 }

deck_three = { 'two_of_hearts' =>  2, 'three_of_hearts' => 3, 'four_of_hearts' =>  4, 'five_of_hearts' =>  5, 'six_of_hearts' =>  6, 'seven_of_hearts' =>  7, 'eight_of_hearts' =>  8, 'nine_of_hearts' =>  9, 'ten_of_hearts' =>  10, 'jack_of_hearts' =>  10, 'queen_of_hearts' => 10, 'king_of_hearts' => 10, 'ace_of_hearts' => 11, 'two_of_clubs' =>  2, 'three_of_clubs' => 3, 'four_of_clubs' =>  4, 'five_of_clubs' =>  5, 'six_of_clubs' =>  6, 'seven_of_clubs' =>  7, 'eight_of_clubs' =>  8, 'nine_of_clubs' =>  9, 'ten_of_clubs' =>  10, 'jack_of_clubs' =>  10, 'queen_of_clubs' => 10, 'king_of_clubs' => 10, 'ace_of_clubs' => 11, 'two_of_spades' =>  2, 'three_of_spades' => 3, 'four_of_spades' =>  4, 'five_of_spades' =>  5, 'six_of_spades' =>  6, 'seven_of_spades' =>  7, 'eight_of_spades' =>  8, 'nine_of_spades' =>  9, 'ten_of_spades' =>  10, 'jack_of_spades' =>  10, 'queen_of_spades' => 10, 'king_of_spades' => 10, 'ace_of_spades' => 11, 'two_of_diamonds' =>  2, 'three_of_diamonds' => 3, 'four_of_diamonds' =>  4, 'five_of_diamonds' =>  5, 'six_of_diamonds' =>  6, 'seven_of_diamonds' =>  7, 'eight_of_diamonds' =>  8, 'nine_of_diamonds' =>  9, 'ten_of_diamonds' =>  10, 'jack_of_diamonds' =>  10, 'queen_of_diamonds' => 10, 'king_of_diamonds' => 10, 'ace_of_diamonds' => 11 }

deck_four = { 'two_of_hearts' =>  2, 'three_of_hearts' => 3, 'four_of_hearts' =>  4, 'five_of_hearts' =>  5, 'six_of_hearts' =>  6, 'seven_of_hearts' =>  7, 'eight_of_hearts' =>  8, 'nine_of_hearts' =>  9, 'ten_of_hearts' =>  10, 'jack_of_hearts' =>  10, 'queen_of_hearts' => 10, 'king_of_hearts' => 10, 'ace_of_hearts' => 11, 'two_of_clubs' =>  2, 'three_of_clubs' => 3, 'four_of_clubs' =>  4, 'five_of_clubs' =>  5, 'six_of_clubs' =>  6, 'seven_of_clubs' =>  7, 'eight_of_clubs' =>  8, 'nine_of_clubs' =>  9, 'ten_of_clubs' =>  10, 'jack_of_clubs' =>  10, 'queen_of_clubs' => 10, 'king_of_clubs' => 10, 'ace_of_clubs' => 11, 'two_of_spades' =>  2, 'three_of_spades' => 3, 'four_of_spades' =>  4, 'five_of_spades' =>  5, 'six_of_spades' =>  6, 'seven_of_spades' =>  7, 'eight_of_spades' =>  8, 'nine_of_spades' =>  9, 'ten_of_spades' =>  10, 'jack_of_spades' =>  10, 'queen_of_spades' => 10, 'king_of_spades' => 10, 'ace_of_spades' => 11, 'two_of_diamonds' =>  2, 'three_of_diamonds' => 3, 'four_of_diamonds' =>  4, 'five_of_diamonds' =>  5, 'six_of_diamonds' =>  6, 'seven_of_diamonds' =>  7, 'eight_of_diamonds' =>  8, 'nine_of_diamonds' =>  9, 'ten_of_diamonds' =>  10, 'jack_of_diamonds' =>  10, 'queen_of_diamonds' => 10, 'king_of_diamonds' => 10, 'ace_of_diamonds' => 11 }

shoe = [deck_one.to_a.shuffle!, deck_two.to_a.shuffle!, deck_three.to_a.shuffle!, deck_four.to_a.shuffle!]

burn_card_stack = []

dealer_hand = []
dealer_sum = 0

player_hand = []
player_sum = 0

def burn_card(shoe, burn_card_stack)
  burn_card_stack << shoe.sample.pop
end

def deal_card_to_dealer(shoe, dealer_hand)
  dealer_hand << shoe.sample.pop
end

def deal_card_to_player(shoe, player_hand)
  player_hand << shoe.sample.pop
end

def calculate_hand_sum(hand)
  num = hand.flatten.select{|num| num.to_i.to_s == num.to_s}
  num.reduce( :+ )
end

def show_hand(hand)
  hand.flatten.select{|card| card.to_i.to_s != card.to_s}
end

# def calculate_dealer_hand_sum(dealer_hand, dealer_sum)
#   values = dealer_hand.flatten.values_at(1, 3)
#   dealer_sum = values.inject(:+)
# end

# def calculate_player_hand_sum(player_hand, player_sum)
#   values = player_hand.flatten.values_at(1, 3, 5)
#   if values[5] == nil
#     values.pop
#     player_sum = values.inject(:+)
#   else
#     values = player_hand.flatten.values_at(1, 3, 5)
#     player_sum = values.inject(:+)
#   end
# end


# def calculate_dealer_hand_sum(dealer_hand, dealer_sum)
#   dealer_sum = dealer_hand.flatten[1]  
#   dealer_hand.flatten!
#   dealer_sum = dealer_hand[1] + dealer_hand[3]
# end

# def calculate_player_hand_sum(player_hand, player_sum)
#   player_hand.flatten!
#   if player_hand[5] == nil
#     player_sum = player_hand[1] + player_hand[3]
#   else
#     player_sum = player_hand[1] + player_hand[3] + player_hand[5]
#   end
# end





puts "Welcome to Blackjack!"

puts "What's your name?"
name = gets.chomp

burn_card(shoe, burn_card_stack)
puts "Card has been burned. No more bets!"

deal_card_to_dealer(shoe, dealer_hand)
deal_card_to_player(shoe, player_hand)
deal_card_to_dealer(shoe, dealer_hand)
deal_card_to_player(shoe, player_hand)

dealer_sum = calculate_hand_sum(dealer_hand)
player_sum = calculate_hand_sum(player_hand)

player_hand = show_hand(player_hand)

puts "---"
say "Dealer's hand: [#{dealer_hand[0][0]}] (plus hidden card...)."
puts "Dealer has #{dealer_hand[0][1]} (plus hidden card...)"

puts "---"
say "#{name}'s hand: #{player_hand}"
puts "#{name}, you've got #{player_sum}."
puts "---"
puts "Do you want to Hit or Stand? (Type '1' to Hit, or '2' to Stand)"

hit_or_stand = gets.chomp.to_s

if hit_or_stand == '1'
  deal_card_to_player(shoe, player_hand)
  say " is holding: #{player_hand[0][0]} | #{player_hand[1][0]} | #{player_hand[2][0]}"
else
  puts "Time to see who won!"
end

puts "Thanks for playing, #{name}!"
