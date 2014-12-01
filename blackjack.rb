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

def check_for_winner(hand)
  if (dealer_sum >= 21) && (dealer_sum > player_sum)
    puts "Dealer wins!"
  elsif (player_sum >= 21) && (player_sum > dealer_sum)
    puts "#{name} wins!"
  elsif (player_sum == 21) && (dealer_sum == 21)
    puts "Push!"
  elsif (player_sum > 21) && (dealer_sum > 21)
    puts "Dealer wins!"
  end
end

deck_one = { 'Two of Hearts' =>  2, 'Three of Hearts' => 3, 'Four of Hearts' =>  4, 'Five of Hearts' =>  5, 'Six of Hearts' =>  6, 'Seven of Hearts' =>  7, 'Eight of Hearts' =>  8, 'Nine of Hearts' =>  9, 'Ten of Hearts' =>  10, 'Jack of Hearts' =>  10, 'Queen of Hearts' => 10, 'King of Hearts' => 10, 'Ace of Hearts' => 11, 'Two of Clubs' =>  2, 'Three of Clubs' => 3, 'Four of Clubs' =>  4, 'Five of Clubs' =>  5, 'Six of Clubs' =>  6, 'Seven of Clubs' =>  7, 'Eight of Clubs' =>  8, 'Nine of Clubs' =>  9, 'Ten of Clubs' =>  10, 'Jack of Clubs' =>  10, 'Queen of Clubs' => 10, 'King of Clubs' => 10, 'Ace of Clubs' => 11, 'Two of Spades' =>  2, 'Three of Spades' => 3, 'Four of Spades' =>  4, 'Five of Spades' =>  5, 'Six of Spades' =>  6, 'Seven of Spades' =>  7, 'Eight of Spades' =>  8, 'Nine of Spades' =>  9, 'Ten of Spades' =>  10, 'Jack of Spades' =>  10, 'Queen of Spades' => 10, 'King of Spades' => 10, 'Ace of Spades' => 11, 'Two of Diamonds' =>  2, 'Three of Diamonds' => 3, 'Four of Diamonds' =>  4, 'Five of Diamonds' =>  5, 'Six of Diamonds' =>  6, 'Seven of Diamonds' =>  7, 'Eight of Diamonds' =>  8, 'Nine of Diamonds' =>  9, 'Ten of Diamonds' =>  10, 'Jack of Diamonds' =>  10, 'Queen of Diamonds' => 10, 'King of Diamonds' => 10, 'Ace of Diamonds' => 11 }

deck_two = { 'Two of Hearts' =>  2, 'Three of Hearts' => 3, 'Four of Hearts' =>  4, 'Five of Hearts' =>  5, 'Six of Hearts' =>  6, 'Seven of Hearts' =>  7, 'Eight of Hearts' =>  8, 'Nine of Hearts' =>  9, 'Ten of Hearts' =>  10, 'Jack of Hearts' =>  10, 'Queen of Hearts' => 10, 'King of Hearts' => 10, 'Ace of Hearts' => 11, 'Two of Clubs' =>  2, 'Three of Clubs' => 3, 'Four of Clubs' =>  4, 'Five of Clubs' =>  5, 'Six of Clubs' =>  6, 'Seven of Clubs' =>  7, 'Eight of Clubs' =>  8, 'Nine of Clubs' =>  9, 'Ten of Clubs' =>  10, 'Jack of Clubs' =>  10, 'Queen of Clubs' => 10, 'King of Clubs' => 10, 'Ace of Clubs' => 11, 'Two of Spades' =>  2, 'Three of Spades' => 3, 'Four of Spades' =>  4, 'Five of Spades' =>  5, 'Six of Spades' =>  6, 'Seven of Spades' =>  7, 'Eight of Spades' =>  8, 'Nine of Spades' =>  9, 'Ten of Spades' =>  10, 'Jack of Spades' =>  10, 'Queen of Spades' => 10, 'King of Spades' => 10, 'Ace of Spades' => 11, 'Two of Diamonds' =>  2, 'Three of Diamonds' => 3, 'Four of Diamonds' =>  4, 'Five of Diamonds' =>  5, 'Six of Diamonds' =>  6, 'Seven of Diamonds' =>  7, 'Eight of Diamonds' =>  8, 'Nine of Diamonds' =>  9, 'Ten of Diamonds' =>  10, 'Jack of Diamonds' =>  10, 'Queen of Diamonds' => 10, 'King of Diamonds' => 10, 'Ace of Diamonds' => 11 }

deck_three = { 'Two of Hearts' =>  2, 'Three of Hearts' => 3, 'Four of Hearts' =>  4, 'Five of Hearts' =>  5, 'Six of Hearts' =>  6, 'Seven of Hearts' =>  7, 'Eight of Hearts' =>  8, 'Nine of Hearts' =>  9, 'Ten of Hearts' =>  10, 'Jack of Hearts' =>  10, 'Queen of Hearts' => 10, 'King of Hearts' => 10, 'Ace of Hearts' => 11, 'Two of Clubs' =>  2, 'Three of Clubs' => 3, 'Four of Clubs' =>  4, 'Five of Clubs' =>  5, 'Six of Clubs' =>  6, 'Seven of Clubs' =>  7, 'Eight of Clubs' =>  8, 'Nine of Clubs' =>  9, 'Ten of Clubs' =>  10, 'Jack of Clubs' =>  10, 'Queen of Clubs' => 10, 'King of Clubs' => 10, 'Ace of Clubs' => 11, 'Two of Spades' =>  2, 'Three of Spades' => 3, 'Four of Spades' =>  4, 'Five of Spades' =>  5, 'Six of Spades' =>  6, 'Seven of Spades' =>  7, 'Eight of Spades' =>  8, 'Nine of Spades' =>  9, 'Ten of Spades' =>  10, 'Jack of Spades' =>  10, 'Queen of Spades' => 10, 'King of Spades' => 10, 'Ace of Spades' => 11, 'Two of Diamonds' =>  2, 'Three of Diamonds' => 3, 'Four of Diamonds' =>  4, 'Five of Diamonds' =>  5, 'Six of Diamonds' =>  6, 'Seven of Diamonds' =>  7, 'Eight of Diamonds' =>  8, 'Nine of Diamonds' =>  9, 'Ten of Diamonds' =>  10, 'Jack of Diamonds' =>  10, 'Queen of Diamonds' => 10, 'King of Diamonds' => 10, 'Ace of Diamonds' => 11 }

deck_four = { 'Two of Hearts' =>  2, 'Three of Hearts' => 3, 'Four of Hearts' =>  4, 'Five of Hearts' =>  5, 'Six of Hearts' =>  6, 'Seven of Hearts' =>  7, 'Eight of Hearts' =>  8, 'Nine of Hearts' =>  9, 'Ten of Hearts' =>  10, 'Jack of Hearts' =>  10, 'Queen of Hearts' => 10, 'King of Hearts' => 10, 'Ace of Hearts' => 11, 'Two of Clubs' =>  2, 'Three of Clubs' => 3, 'Four of Clubs' =>  4, 'Five of Clubs' =>  5, 'Six of Clubs' =>  6, 'Seven of Clubs' =>  7, 'Eight of Clubs' =>  8, 'Nine of Clubs' =>  9, 'Ten of Clubs' =>  10, 'Jack of Clubs' =>  10, 'Queen of Clubs' => 10, 'King of Clubs' => 10, 'Ace of Clubs' => 11, 'Two of Spades' =>  2, 'Three of Spades' => 3, 'Four of Spades' =>  4, 'Five of Spades' =>  5, 'Six of Spades' =>  6, 'Seven of Spades' =>  7, 'Eight of Spades' =>  8, 'Nine of Spades' =>  9, 'Ten of Spades' =>  10, 'Jack of Spades' =>  10, 'Queen of Spades' => 10, 'King of Spades' => 10, 'Ace of Spades' => 11, 'Two of Diamonds' =>  2, 'Three of Diamonds' => 3, 'Four of Diamonds' =>  4, 'Five of Diamonds' =>  5, 'Six of Diamonds' =>  6, 'Seven of Diamonds' =>  7, 'Eight of Diamonds' =>  8, 'Nine of Diamonds' =>  9, 'Ten of Diamonds' =>  10, 'Jack of Diamonds' =>  10, 'Queen of Diamonds' => 10, 'King of Diamonds' => 10, 'Ace of Diamonds' => 11 }

# shoe = [deck_one.to_a.shuffle!, deck_two.to_a.shuffle!, deck_three.to_a.shuffle!, deck_four.to_a.shuffle!]

# burn_card_stack = []

# dealer_hand = []
# dealer_sum = 0

# player_hand = []
# player_sum = 0

def burn_card(shoe, burn_card_stack)
  burn_card_stack << shoe.sample.pop
end

def deal_card(shoe, hand)
  hand << shoe.sample.pop
end

def calculate_hand_sum(hand)
  sum = hand.map{|e| e[1]}
  total = 0
  sum.each do |value|
    total += value.to_i
  end

  sum.select{|e| e == 11}.count.times do
    total -= 10 if total > 21
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

puts "Place your bet. (You have $500)!"
bet = gets.chomp.to_i

say "#{name} bets \$#{bet}..."
sleep 0.5

shoe = [deck_one.to_a.shuffle!, deck_two.to_a.shuffle!, deck_three.to_a.shuffle!, deck_four.to_a.shuffle!]

burn_card_stack = []
burn_card(shoe, burn_card_stack)

puts "Card has been burned. No more bets!"
sleep 2.5

dealer_hand = []
dealer_sum = 0

player_hand = []
player_sum = 0

deal_card(shoe, player_hand)
deal_card(shoe, dealer_hand)
deal_card(shoe, player_hand)
deal_card(shoe, dealer_hand)

player_sum = calculate_hand_sum(player_hand)
dealer_sum = calculate_hand_sum(dealer_hand)

player_first_card = player_hand[0][0]
player_first_card_sum = player_hand[0][1]
player_second_card = player_hand[1][0]
player_second_card_sum = player_hand[1][1]

dealer_up_card = dealer_hand[0][0]
dealer_up_card_sum = dealer_hand[0][1]

player_hand = show_hand(player_hand)
dealer_hand = show_hand(dealer_hand)

puts "---"
puts "Dealer receives first card."
sleep 1.0
puts "#{name} receives first card."
sleep 1.0
puts "Dealer receives second card."
sleep 1.0
puts "#{name} receives second card."
sleep 1.0
system 'clear'
puts "---"
puts "Dealer has one 'up card' (visible) , and a hidden card."
say "The up card is: [#{dealer_up_card}], with a value of #{dealer_up_card_sum}."
#puts "The value of all of Dealer's visible cards is: #{dealer_up_card_sum}."

if dealer_up_card_sum == 11
  puts "The dealer got an Ace. In a moment, you can make an insurance bet, if you want."
else
end

sleep 0.5
puts "---"
say "#{name}'s hand: #{player_hand}"
puts "#{name} has #{player_sum}."
puts "---"
#sleep 0.5

if player_sum == 21
  puts "Congratulations, #{name}! You've hit Blackjack! You've won!"
  exit
elsif 
  dealer_sum == 21
  say "Dealer's hand: #{dealer_hand}"
  puts "Sorry, Dealer hit Blackjack. You lose."
  exit
elsif player_sum > 25
  say "#{name}'s hand: #{player_hand}"
  puts "Sorry, you've busted. You lose."
  exit
end

while player_sum < 21
  puts "Do you want to Hit or Stand, or do something else? (Type '1' to Hit, '2' to Stand, '3' to Double Down, '4' for an Insurance Bet, or '?' for Help)"
  say "Enter [1], [2], [3], [4], or [?]."
  hit_or_stand = gets.chomp

  if !['1', '2', '3', '4', '?'].include?(hit_or_stand)
    puts "You must enter a '1', '2', '3', '4', or '?'."
    next
  end

  if hit_or_stand == "1"
    puts "#{name} chooses to hit!"
    hit = shoe.sample.pop
    player_hand << hit[0]
    player_sum = (player_sum + hit[1])
    player_hand = show_hand(player_hand)
    system "clear"
    puts "#{name} is receiving another card..."
    sleep 1.0
    system "clear"
    if player_sum > 21
      say "{name}'s hand: #{player_hand}."
      puts "You busted. Dealer wins."
    else
      say "#{name} has #{player_hand}, for a new total of #{player_sum}."
    end
    puts "----"
  elsif
    hit_or_stand == "2"
    puts "#{name} chooses to stand!"
    break
  elsif hit_or_stand == "3"
    system "clear"
    if player_first_card_sum == player_second_card_sum 
      puts "#{name} chooses to double down!"
      puts "How much would you like to bet? You can be the same as you bet in the current hand, or half. (Type '1' for the same amount; type '2' for half."
      double_down_bet = gets.chomp
    else
      puts "You can only double down when the value of your cards are the same."
      puts "---"
      puts "  "
    end
  elsif hit_or_stand == "4"
    system "clear"
    if dealer_up_card_sum == 11
      puts "#{name} chooses to make an insurance bet!"
    else
      puts "Sorry, you can only double down when the Dealer's up card is an Ace. The dealer's up card is: #{dealer_up_card}."
      puts "---"
      puts "  "
    end
  elsif hit_or_stand == "?"
    system "clear"
    puts "Here are you options:"
    say "Choose [1] to hit (get another card). You should definitely hit if the sum of your cards is less than 16. If it's 17 or higher, you'll risk losing by going over 21."
    puts " "
    say "Choose [2] to stand. If you have 17 or higher, this is usually a good choice. If you have 16 or less, don't choose this option, though, because the Dealer will always have at least 17."
    puts " "
    say "Choose [3] to double down. You can only do this if the value of both of your cards was the same. If you double down, you will have two separate hands, with two separate bets. You can bet either the same amount as the first hand, or half."
    puts " "
    say "Choose [4] to make an insurance bet. This is a side bet, separate from your original bet, that the deal will get a Blackjack. You can only make an insurance bet if the dealer's upcard (visible card) is an ACE."
    puts "---"
    puts " "
  end
end

while dealer_sum < 17
  deal_card(shoe, dealer_hand)
  dealer_sum = calculate_hand_sum(dealer_hand)
  
  if dealer_sum == 21
    say "Dealer's hand: #{dealer_hand}"
    puts "Sorry, Dealer hit Blackjack. You lose."
    exit
  elsif dealer_sum > 21
    say "Dealer's hand: #{dealer_hand}"
    puts "Dealer busted. You win!"
  end
end


