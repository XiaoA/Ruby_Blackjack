# Game Logic

# Decks: Will I need more than one deck?

# I'll need:
# - At least one deck (A - K, four suits)
# - A way to keep track of the user's name
# - A way to keep track of all cards available and in use
# - A way to force the dealer to deal at least to 17
# - A way to set 21 as the winning hand, and a way to handle 'busts'
# - A loop that allows the player to continue to play until he/she wants to quit
# - A way to keep track of bet.to_is, and money.
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

# Win/Loss Scenarios
# Player wins
# - Dealer busts, but player doesn't
# - Player gets 21, but dealer doesn't
# - Player gets less than 21, but more than dealer
# - Player gets 21 with two cards (Blackjack) => 3:2 payout
# - Player gets 21 with three or more cards (not Blackjack) => 1:1 payout

# 
# Dealer wins
# - Player busts, but dealer doesn't
# - Dealer gets 21, but player doesn't
# - Dealer gets less than 21, but more than player
# - Dealer gets 21 with two cards (Blackjack) => 3:2 payout
# - Dealer gets 21 with three or more cards (not Blackjack) => 1:1 payout

# Tie (push/no winner)
# - Dealer gets 17 ~ 21, and the player gets the same score
# 
# Tie (player loses)
# - Both dealer and player bust


# Procedural Blackboard Game, written in Ruby
require 'pry'

def say(msg)
  puts "=> #{msg}"
end

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

deck_one = { 'Two of Hearts' =>  2, 'Three of Hearts' => 3, 'Four of Hearts' =>  4, 'Five of Hearts' =>  5, 'Six of Hearts' =>  6, 'Seven of Hearts' =>  7, 'Eight of Hearts' =>  8, 'Nine of Hearts' =>  9, 'Ten of Hearts' =>  10, 'Jack of Hearts' =>  10, 'Queen of Hearts' => 10, 'King of Hearts' => 10, 'Ace of Hearts' => 11, 'Two of Clubs' =>  2, 'Three of Clubs' => 3, 'Four of Clubs' =>  4, 'Five of Clubs' =>  5, 'Six of Clubs' =>  6, 'Seven of Clubs' =>  7, 'Eight of Clubs' =>  8, 'Nine of Clubs' =>  9, 'Ten of Clubs' =>  10, 'Jack of Clubs' =>  10, 'Queen of Clubs' => 10, 'King of Clubs' => 10, 'Ace of Clubs' => 11, 'Two of Spades' =>  2, 'Three of Spades' => 3, 'Four of Spades' =>  4, 'Five of Spades' =>  5, 'Six of Spades' =>  6, 'Seven of Spades' =>  7, 'Eight of Spades' =>  8, 'Nine of Spades' =>  9, 'Ten of Spades' =>  10, 'Jack of Spades' =>  10, 'Queen of Spades' => 10, 'King of Spades' => 10, 'Ace of Spades' => 11, 'Two of Diamonds' =>  2, 'Three of Diamonds' => 3, 'Four of Diamonds' =>  4, 'Five of Diamonds' =>  5, 'Six of Diamonds' =>  6, 'Seven of Diamonds' =>  7, 'Eight of Diamonds' =>  8, 'Nine of Diamonds' =>  9, 'Ten of Diamonds' =>  10, 'Jack of Diamonds' =>  10, 'Queen of Diamonds' => 10, 'King of Diamonds' => 10, 'Ace of Diamonds' => 11 }

deck_two = { 'Two of Hearts' =>  2, 'Three of Hearts' => 3, 'Four of Hearts' =>  4, 'Five of Hearts' =>  5, 'Six of Hearts' =>  6, 'Seven of Hearts' =>  7, 'Eight of Hearts' =>  8, 'Nine of Hearts' =>  9, 'Ten of Hearts' =>  10, 'Jack of Hearts' =>  10, 'Queen of Hearts' => 10, 'King of Hearts' => 10, 'Ace of Hearts' => 11, 'Two of Clubs' =>  2, 'Three of Clubs' => 3, 'Four of Clubs' =>  4, 'Five of Clubs' =>  5, 'Six of Clubs' =>  6, 'Seven of Clubs' =>  7, 'Eight of Clubs' =>  8, 'Nine of Clubs' =>  9, 'Ten of Clubs' =>  10, 'Jack of Clubs' =>  10, 'Queen of Clubs' => 10, 'King of Clubs' => 10, 'Ace of Clubs' => 11, 'Two of Spades' =>  2, 'Three of Spades' => 3, 'Four of Spades' =>  4, 'Five of Spades' =>  5, 'Six of Spades' =>  6, 'Seven of Spades' =>  7, 'Eight of Spades' =>  8, 'Nine of Spades' =>  9, 'Ten of Spades' =>  10, 'Jack of Spades' =>  10, 'Queen of Spades' => 10, 'King of Spades' => 10, 'Ace of Spades' => 11, 'Two of Diamonds' =>  2, 'Three of Diamonds' => 3, 'Four of Diamonds' =>  4, 'Five of Diamonds' =>  5, 'Six of Diamonds' =>  6, 'Seven of Diamonds' =>  7, 'Eight of Diamonds' =>  8, 'Nine of Diamonds' =>  9, 'Ten of Diamonds' =>  10, 'Jack of Diamonds' =>  10, 'Queen of Diamonds' => 10, 'King of Diamonds' => 10, 'Ace of Diamonds' => 11 }

deck_three = { 'Two of Hearts' =>  2, 'Three of Hearts' => 3, 'Four of Hearts' =>  4, 'Five of Hearts' =>  5, 'Six of Hearts' =>  6, 'Seven of Hearts' =>  7, 'Eight of Hearts' =>  8, 'Nine of Hearts' =>  9, 'Ten of Hearts' =>  10, 'Jack of Hearts' =>  10, 'Queen of Hearts' => 10, 'King of Hearts' => 10, 'Ace of Hearts' => 11, 'Two of Clubs' =>  2, 'Three of Clubs' => 3, 'Four of Clubs' =>  4, 'Five of Clubs' =>  5, 'Six of Clubs' =>  6, 'Seven of Clubs' =>  7, 'Eight of Clubs' =>  8, 'Nine of Clubs' =>  9, 'Ten of Clubs' =>  10, 'Jack of Clubs' =>  10, 'Queen of Clubs' => 10, 'King of Clubs' => 10, 'Ace of Clubs' => 11, 'Two of Spades' =>  2, 'Three of Spades' => 3, 'Four of Spades' =>  4, 'Five of Spades' =>  5, 'Six of Spades' =>  6, 'Seven of Spades' =>  7, 'Eight of Spades' =>  8, 'Nine of Spades' =>  9, 'Ten of Spades' =>  10, 'Jack of Spades' =>  10, 'Queen of Spades' => 10, 'King of Spades' => 10, 'Ace of Spades' => 11, 'Two of Diamonds' =>  2, 'Three of Diamonds' => 3, 'Four of Diamonds' =>  4, 'Five of Diamonds' =>  5, 'Six of Diamonds' =>  6, 'Seven of Diamonds' =>  7, 'Eight of Diamonds' =>  8, 'Nine of Diamonds' =>  9, 'Ten of Diamonds' =>  10, 'Jack of Diamonds' =>  10, 'Queen of Diamonds' => 10, 'King of Diamonds' => 10, 'Ace of Diamonds' => 11 }

deck_four = { 'Two of Hearts' =>  2, 'Three of Hearts' => 3, 'Four of Hearts' =>  4, 'Five of Hearts' =>  5, 'Six of Hearts' =>  6, 'Seven of Hearts' =>  7, 'Eight of Hearts' =>  8, 'Nine of Hearts' =>  9, 'Ten of Hearts' =>  10, 'Jack of Hearts' =>  10, 'Queen of Hearts' => 10, 'King of Hearts' => 10, 'Ace of Hearts' => 11, 'Two of Clubs' =>  2, 'Three of Clubs' => 3, 'Four of Clubs' =>  4, 'Five of Clubs' =>  5, 'Six of Clubs' =>  6, 'Seven of Clubs' =>  7, 'Eight of Clubs' =>  8, 'Nine of Clubs' =>  9, 'Ten of Clubs' =>  10, 'Jack of Clubs' =>  10, 'Queen of Clubs' => 10, 'King of Clubs' => 10, 'Ace of Clubs' => 11, 'Two of Spades' =>  2, 'Three of Spades' => 3, 'Four of Spades' =>  4, 'Five of Spades' =>  5, 'Six of Spades' =>  6, 'Seven of Spades' =>  7, 'Eight of Spades' =>  8, 'Nine of Spades' =>  9, 'Ten of Spades' =>  10, 'Jack of Spades' =>  10, 'Queen of Spades' => 10, 'King of Spades' => 10, 'Ace of Spades' => 11, 'Two of Diamonds' =>  2, 'Three of Diamonds' => 3, 'Four of Diamonds' =>  4, 'Five of Diamonds' =>  5, 'Six of Diamonds' =>  6, 'Seven of Diamonds' =>  7, 'Eight of Diamonds' =>  8, 'Nine of Diamonds' =>  9, 'Ten of Diamonds' =>  10, 'Jack of Diamonds' =>  10, 'Queen of Diamonds' => 10, 'King of Diamonds' => 10, 'Ace of Diamonds' => 11 }

shoe = [deck_one.to_a.shuffle!, deck_two.to_a.shuffle!, deck_three.to_a.shuffle!, deck_four.to_a.shuffle!]

system "clear"
puts " "
puts "====================="
puts "Welcome to Blackjack!"
puts "====================="
puts " "
puts "What's your name?"
name = gets.chomp

player_cash_pot = 500  

dealer_sum = 0
player_sum = 0
push = nil

loop do
  system 'clear'
  if push == nil
    puts "---"
    puts "The minimum bet is $5, and the maximum is $500."
    puts "Please choose a number between 5 and 500 (Numbers only, no '$' or decimals, please...)"
    puts "---"
    puts "  "
    puts "Place your bet. (You have \$#{player_cash_pot})!"

    bet = gets.chomp.to_i
  else
  end

  sleep 0.5

  burn_card_stack = []
  burn_card(shoe, burn_card_stack)

  puts "No more bets!"
  sleep 2.5
  system "clear"

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

  dealer_first_card = dealer_hand[0][0]
  dealer_first_card_sum = dealer_hand[0][1]
  dealer_second_card = dealer_hand[1][0]
  dealer_second_card_sum = dealer_hand[1][1]
  
  player_hand = show_hand(player_hand)
  dealer_hand = show_hand(dealer_hand)

  puts "---"
  puts "(Dealer burns first card)"
  puts "  "
  sleep 0.5
  puts "#{name} receives first card."
  sleep 1.0
  puts "Dealer receives first card."
  sleep 1.0
  puts "#{name} receives second card."
  sleep 1.0
  puts "Dealer receives second card."
  sleep 1.0
  system 'clear'
  puts "---"
  puts "Dealer has one 'up card' (visible) , and a hidden card."
  puts "The up card is: [#{dealer_first_card}]."
  say "Dealer has #{dealer_first_card_sum}."

  sleep 0.5
  puts "---"
  puts "#{name}'s hand: #{player_hand}"
  say "#{name} has #{player_sum}."
  puts "---"

  while player_sum < 21
    puts "Do you want to Hit or Stand?"
    puts "Type '1' to Hit"
    puts "Type '2' to Stand" 
    puts " "
    say "Enter [1] or [2]."
    hit_or_stand = gets.chomp
    
    if !['1', '2'].include?(hit_or_stand)
      puts "You must enter a '1', or a '2'."
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
      say "#{name} has #{player_hand}, for a new total of #{player_sum}."
      puts "----"
    elsif hit_or_stand == "2"
      puts "#{name} chooses to stand!"
      system "clear"
      puts "Your hand: #{player_hand} has a value of #{player_sum}."
      puts "---"
      break
    end
  end

  while dealer_sum < 17
    hit = shoe.sample.pop
    dealer_hand << hit[0]
    dealer_sum = (dealer_sum + hit[1])
    dealer_hand = show_hand(dealer_hand)                  
  end

#  binding.pry

  if (dealer_sum > 21) && (player_sum < 21)
    system 'clear'
    puts "---"
    puts "#{name}'s hand: #{player_hand}"
    say "value: #{player_sum}"
    puts "---"
    puts "Dealer's hand: #{dealer_hand}"
    say "value: #{dealer_sum}"
    puts "---"
    puts "  "
    say "Dealer busted. You win!"
    puts "  "
    player_cash_pot = (player_cash_pot.to_i + bet.to_i)
    puts "You won \$#{bet}. You now have #{player_cash_pot}."
  elsif (player_first_card_sum + player_second_card.sum == 21) && (dealer_sum != 21)
    system 'clear'
    puts "---"
    puts "#{name}'s hand: #{player_hand}"
    say "value: #{player_sum}"
    puts "---"
    puts "Dealer's hand: #{dealer_hand}"
    say "value: #{dealer_sum}"
    puts "---"
    puts "  "
    say "#{name} got Blackjack!"
    puts "  "
    player_cash_pot = player_cash_pot.to_i + (bet.to_i * 1.5)
    puts "You won \$#{bet.to_i * 1.5}. You now have \$#{player_cash_pot}."
  elsif (player_sum < 21) && (dealer_sum < player_sum)
    system 'clear'
    puts "---"
    puts "#{name}'s hand: #{player_hand}"
    say "value: #{player_sum}"
    puts "---"
    puts "Dealer's hand: #{dealer_hand}"
    say "value: #{dealer_sum}"
    puts "---"
    puts "  "
    puts "#{name} wins!"
    puts "  "
    player_cash_pot = (player_cash_pot.to_i + bet.to_i)
    puts "You won \$#{bet.to_i}. You now have \$#{player_cash_pot}."
  elsif (player_sum < 21) && (dealer_sum < player_sum)
    system 'clear'
    puts "---"
    puts "#{name}'s hand: #{player_hand}"
    say "value: #{player_sum}"
    puts "---"
    puts "Dealer's hand: #{dealer_hand}"
    say "value: #{dealer_sum}"
    puts "---"
    puts "  "
    say "#{name} wins!"
    puts "  "
    player_cash_pot = (player_cash_pot.to_i + bet.to_i)
    puts "You won \$#{bet.to_i}. You now have \$#{player_cash_pot}."
  elsif player_sum > 21 && dealer_sum < 21
    system 'clear'
    puts "---"
    puts "#{name}'s hand: #{player_hand}"
    say "value: #{player_sum}"
    puts "---"
    puts "Dealer's hand: #{dealer_hand}"
    say "value: #{dealer_sum}"
    puts "---"
    puts "  "
    say "You busted!"
    puts "  "
    player_cash_pot = (player_cash_pot.to_i - bet.to_i)
    puts "You lost \$#{bet.to_i}. You now have \$#{player_cash_pot}."
  elsif (dealer_first_card.sum + dealer_second_card.sum == 21) && (player_sum != 21)
    system 'clear'
    puts "---"
    puts "#{name}'s hand: #{player_hand},"
    say "value: #{player_sum}"
    puts "---"
    puts "Dealer's hand: #{dealer_hand},"
    say "value: #{dealer_sum}"
    puts "---"
    say "dealer got blackjack!"
    player_cash_pot = (player_cash_pot.to_i - bet.to_i)
    puts "You lost \$#{bet}. You now have \$#{player_cash_pot}."
  elsif (dealer_sum < 21) && (player_sum < dealer_sum)
    system 'clear'
    puts "---"
    puts "#{name}'s hand: #{player_hand},"
    say "value: #{player_sum}"
    puts "---"
    puts "Dealer's hand: #{dealer_hand},"
    say "value: #{dealer_sum}"
    puts "---"
    puts "  "
    say "Dealer wins"
    player_cash_pot = (player_cash_pot.to_i - bet.to_i)
    puts "You lost \$#{bet}. You now have \$#{player_cash_pot}."
  elsif (dealer_sum >= 17) && (dealer_sum <= 21) && (dealer_sum == player_sum) 
    system 'clear'
    push = (dealer_sum >= 17) && (dealer_sum <= 21) && (dealer_sum == player_sum) 
    puts "---"
    puts "#{name}'s hand: #{player_hand},"
    say "value: #{player_sum}"
    puts "---"
    puts "Dealer's hand: #{dealer_hand},"
    say "value: #{dealer_sum}"
    puts "---"
    puts "  "
    say "push"
  elsif (dealer_sum > 21) && (player_sum > 21)
    system 'clear'
    puts "---"
    puts "#{name}'s hand: #{player_hand},"
    say "value: #{player_sum}"
    puts "---"
    puts "Dealer's hand: #{dealer_hand},"
    say "value: #{dealer_sum}"
    puts "---"
    puts "  "
    say "We both busted. Player loses."
    player_cash_pot = (player_cash_pot.to_i - bet.to_i)
    puts "You lost \$#{bet}. You now have \$#{player_cash_pot}."
  end

  if player_cash_pot != 0
    puts "Would you like to play again? (y/n)"
    play_again = gets.chomp.downcase
  else
    "It looks like you're out of money, #{name}."
    break
  end
  break if play_again == 'n'
end

puts "Thanks for playing!"
sleep 7.0
system 'clear'
