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

deck_one = { 'Two of Hearts' =>  2, 'Three of Hearts' => 3, 'Four of Hearts' =>  4, 'Five of Hearts' =>  5, 'Six of Hearts' =>  6, 'Seven of Hearts' =>  7, 'Eight of Hearts' =>  8, 'Nine of Hearts' =>  9, 'Ten of Hearts' =>  10, 'Jack of Hearts' =>  10, 'Queen of Hearts' => 10, 'King of Hearts' => 10, 'Ace of Hearts' => 11, 'Two of Clubs' =>  2, 'Three of Clubs' => 3, 'Four of Clubs' =>  4, 'Five of Clubs' =>  5, 'Six of Clubs' =>  6, 'Seven of Clubs' =>  7, 'Eight of Clubs' =>  8, 'Nine of Clubs' =>  9, 'Ten of Clubs' =>  10, 'Jack of Clubs' =>  10, 'Queen of Clubs' => 10, 'King of Clubs' => 10, 'Ace of Clubs' => 11, 'Two of Spades' =>  2, 'Three of Spades' => 3, 'Four of Spades' =>  4, 'Five of Spades' =>  5, 'Six of Spades' =>  6, 'Seven of Spades' =>  7, 'Eight of Spades' =>  8, 'Nine of Spades' =>  9, 'Ten of Spades' =>  10, 'Jack of Spades' =>  10, 'Queen of Spades' => 10, 'King of Spades' => 10, 'Ace of Spades' => 11, 'Two of Diamonds' =>  2, 'Three of Diamonds' => 3, 'Four of Diamonds' =>  4, 'Five of Diamonds' =>  5, 'Six of Diamonds' =>  6, 'Seven of Diamonds' =>  7, 'Eight of Diamonds' =>  8, 'Nine of Diamonds' =>  9, 'Ten of Diamonds' =>  10, 'Jack of Diamonds' =>  10, 'Queen of Diamonds' => 10, 'King of Diamonds' => 10, 'Ace of Diamonds' => 11 }

deck_two = { 'Two of Hearts' =>  2, 'Three of Hearts' => 3, 'Four of Hearts' =>  4, 'Five of Hearts' =>  5, 'Six of Hearts' =>  6, 'Seven of Hearts' =>  7, 'Eight of Hearts' =>  8, 'Nine of Hearts' =>  9, 'Ten of Hearts' =>  10, 'Jack of Hearts' =>  10, 'Queen of Hearts' => 10, 'King of Hearts' => 10, 'Ace of Hearts' => 11, 'Two of Clubs' =>  2, 'Three of Clubs' => 3, 'Four of Clubs' =>  4, 'Five of Clubs' =>  5, 'Six of Clubs' =>  6, 'Seven of Clubs' =>  7, 'Eight of Clubs' =>  8, 'Nine of Clubs' =>  9, 'Ten of Clubs' =>  10, 'Jack of Clubs' =>  10, 'Queen of Clubs' => 10, 'King of Clubs' => 10, 'Ace of Clubs' => 11, 'Two of Spades' =>  2, 'Three of Spades' => 3, 'Four of Spades' =>  4, 'Five of Spades' =>  5, 'Six of Spades' =>  6, 'Seven of Spades' =>  7, 'Eight of Spades' =>  8, 'Nine of Spades' =>  9, 'Ten of Spades' =>  10, 'Jack of Spades' =>  10, 'Queen of Spades' => 10, 'King of Spades' => 10, 'Ace of Spades' => 11, 'Two of Diamonds' =>  2, 'Three of Diamonds' => 3, 'Four of Diamonds' =>  4, 'Five of Diamonds' =>  5, 'Six of Diamonds' =>  6, 'Seven of Diamonds' =>  7, 'Eight of Diamonds' =>  8, 'Nine of Diamonds' =>  9, 'Ten of Diamonds' =>  10, 'Jack of Diamonds' =>  10, 'Queen of Diamonds' => 10, 'King of Diamonds' => 10, 'Ace of Diamonds' => 11 }

deck_three = { 'Two of Hearts' =>  2, 'Three of Hearts' => 3, 'Four of Hearts' =>  4, 'Five of Hearts' =>  5, 'Six of Hearts' =>  6, 'Seven of Hearts' =>  7, 'Eight of Hearts' =>  8, 'Nine of Hearts' =>  9, 'Ten of Hearts' =>  10, 'Jack of Hearts' =>  10, 'Queen of Hearts' => 10, 'King of Hearts' => 10, 'Ace of Hearts' => 11, 'Two of Clubs' =>  2, 'Three of Clubs' => 3, 'Four of Clubs' =>  4, 'Five of Clubs' =>  5, 'Six of Clubs' =>  6, 'Seven of Clubs' =>  7, 'Eight of Clubs' =>  8, 'Nine of Clubs' =>  9, 'Ten of Clubs' =>  10, 'Jack of Clubs' =>  10, 'Queen of Clubs' => 10, 'King of Clubs' => 10, 'Ace of Clubs' => 11, 'Two of Spades' =>  2, 'Three of Spades' => 3, 'Four of Spades' =>  4, 'Five of Spades' =>  5, 'Six of Spades' =>  6, 'Seven of Spades' =>  7, 'Eight of Spades' =>  8, 'Nine of Spades' =>  9, 'Ten of Spades' =>  10, 'Jack of Spades' =>  10, 'Queen of Spades' => 10, 'King of Spades' => 10, 'Ace of Spades' => 11, 'Two of Diamonds' =>  2, 'Three of Diamonds' => 3, 'Four of Diamonds' =>  4, 'Five of Diamonds' =>  5, 'Six of Diamonds' =>  6, 'Seven of Diamonds' =>  7, 'Eight of Diamonds' =>  8, 'Nine of Diamonds' =>  9, 'Ten of Diamonds' =>  10, 'Jack of Diamonds' =>  10, 'Queen of Diamonds' => 10, 'King of Diamonds' => 10, 'Ace of Diamonds' => 11 }

deck_four = { 'Two of Hearts' =>  2, 'Three of Hearts' => 3, 'Four of Hearts' =>  4, 'Five of Hearts' =>  5, 'Six of Hearts' =>  6, 'Seven of Hearts' =>  7, 'Eight of Hearts' =>  8, 'Nine of Hearts' =>  9, 'Ten of Hearts' =>  10, 'Jack of Hearts' =>  10, 'Queen of Hearts' => 10, 'King of Hearts' => 10, 'Ace of Hearts' => 11, 'Two of Clubs' =>  2, 'Three of Clubs' => 3, 'Four of Clubs' =>  4, 'Five of Clubs' =>  5, 'Six of Clubs' =>  6, 'Seven of Clubs' =>  7, 'Eight of Clubs' =>  8, 'Nine of Clubs' =>  9, 'Ten of Clubs' =>  10, 'Jack of Clubs' =>  10, 'Queen of Clubs' => 10, 'King of Clubs' => 10, 'Ace of Clubs' => 11, 'Two of Spades' =>  2, 'Three of Spades' => 3, 'Four of Spades' =>  4, 'Five of Spades' =>  5, 'Six of Spades' =>  6, 'Seven of Spades' =>  7, 'Eight of Spades' =>  8, 'Nine of Spades' =>  9, 'Ten of Spades' =>  10, 'Jack of Spades' =>  10, 'Queen of Spades' => 10, 'King of Spades' => 10, 'Ace of Spades' => 11, 'Two of Diamonds' =>  2, 'Three of Diamonds' => 3, 'Four of Diamonds' =>  4, 'Five of Diamonds' =>  5, 'Six of Diamonds' =>  6, 'Seven of Diamonds' =>  7, 'Eight of Diamonds' =>  8, 'Nine of Diamonds' =>  9, 'Ten of Diamonds' =>  10, 'Jack of Diamonds' =>  10, 'Queen of Diamonds' => 10, 'King of Diamonds' => 10, 'Ace of Diamonds' => 11 }

shoe = [deck_one.to_a.shuffle!, deck_two.to_a.shuffle!, deck_three.to_a.shuffle!, deck_four.to_a.shuffle!]

burn_card_stack = []

dealer_hand = []
dealer_sum = 0

player_hand = []
player_sum = 0

def burn_card(shoe, burn_card_stack)
  burn_card_stack << shoe.sample.pop
end

def deal_card(shoe, hand)
  hand << shoe.sample.pop
end

# def calculate_hand_sum(hand)
#   sum = hand.flatten.select { |num| num.to_s =~ /\d+$/ }
#   sum.reduce(:+)
# end

def calculate_hand_sum(hand)
  sum = hand.map{|e| e[1]}

  total = 0
  sum.each do |value|
    if value == "A"
      total += 11
    else
      total += value.to_i
    end

    sum.select{|e| e == "A"}.count.times do
      total -= 10 if total > 21
    end
  end
  total
end

def show_hand(hand)
  hand.flatten.select { |card| card.to_s =~ /\D+$/ }
end

puts " "
puts "====================="
puts "Welcome to Blackjack!"
puts "====================="
puts " "
puts "What's your name?"
name = gets.chomp

loop do
puts "Place your bet. (You have $500)!"
bet = gets.chomp.to_i

say "#{name} bets \$#{bet}..."
sleep 0.5
burn_card(shoe, burn_card_stack)

puts "Card has been burned. No more bets!"
sleep 2.5

deal_card(shoe, dealer_hand)
deal_card(shoe, player_hand)
deal_card(shoe, dealer_hand)
deal_card(shoe, player_hand)


dealer_sum = calculate_hand_sum(dealer_hand)
player_sum = calculate_hand_sum(player_hand)

player_hand = show_hand(player_hand)

puts "---"
puts "Dealer receives first card."
sleep 1.0
puts "#{name} receives first card."
sleep 1.0
puts "Dealer receives second card."
sleep 1.0
puts "#{name} receives second card."
sleep 1.0
puts "---"
say "Dealer's hand: [#{dealer_hand[0][0]}] (plus hidden card...)."
puts "Dealer has #{dealer_hand[0][1]} (plus hidden card...)"
sleep 0.5
puts "---"
say "#{name}'s hand: #{player_hand}"
puts "#{name} has #{player_sum}."
puts "---"

sleep 0.5

# blackjack_or_bust(dealer_hand, player_hand)

puts "Do you want to Hit or Stand? (Type 'h' to Hit, or 's' to Stand)"
hit_or_stand = gets.chomp.downcase


if hit_or_stand == 'h'
  deal_card(shoe, player_hand)
  player_sum = calculate_hand_sum(player_hand)
  player_hand = show_hand(player_hand)
  say "#{name}'s hand: #{player_hand}"
  puts "#{name} has #{player_sum}."
else
  puts "#{name} stands with #{player_sum}!"
end



puts "Would you like to play again? (y/n)"
play_again = gets.chomp.downcase

break if play_again == 'n'
end

puts "Thanks for playing, #{name}!"




