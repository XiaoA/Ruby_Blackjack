# require 'rubygems'
# require 'pry'

# Object-Oriented Blackjack Game

class Card
  attr_accessor :suit, :face_value

  def initialize(suit, face_value)
    @suit = suit
    @face_value = face_value
  end

  def pretty_output
    "The #{face_value} of #{find_suit}"
  end

  def to_s
    pretty_output
  end

  def find_suit
    ret_val = case suit
              when 'H' then 'Hearts'
              when 'D' then 'Diamonds'
              when 'S' then 'Spades'
              when 'C' then 'Clubs'
              end
    ret_val
  end
end

class Deck
  attr_accessor :cards

  def initialize
    @cards = []
    ['H', 'D', 'S', 'C'].each do |suit|
      ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K', 'A'].each do |face_value|
        @cards << Card.new(suit, face_value)
      end
    end
    shuffle!
  end

  def shuffle!
    cards.shuffle!
  end

  def deal_card
    cards.pop
  end

  def size
    cards.size
  end
end

module Hand
  def show_hand
    puts "---- #{name}'s Hand ----"
    cards.each do|card|
      puts "=> #{card}"
    end
    puts "=> Total: #{total}"
    puts "---"
    puts " "
  end

  def total
    face_values = cards.map{|card| card.face_value }

    total = 0
    face_values.each do |val|
      if val == "A"
        total += 11
      else
        total += (val.to_i == 0 ? 10 : val.to_i)
      end
    end

    # Correct for Aces
    face_values.select{|val| val == "A"}.count.times do
      break if total <= 21
      total -= 10
    end
    total
  end

  def add_card(new_card)
    cards << new_card
  end

  def is_busted?
    total > Game::BLACKJACK_AMOUNT
  end
end

class Player
  include Hand

  attr_accessor :name, :cards, :bet, :cash_pot

  def initialize
    @name = name
    @cards = []
    @bet = bet
    @cash_pot = cash_pot
  end
end

class Dealer
  include Hand

  attr_accessor :name, :cards

  def initialize
    @name = "Dealer"
    @cards = []
  end

  def show_upcard_only
    puts "---- Dealer's Hand ----"
    puts "=> The first card is hidden"
    puts "=> The second card is #{cards[1]}"
    puts "---"
    puts " "
  end
end

class Game
  attr_accessor :deck, :player, :dealer, :cash_pot, :bet

  BLACKJACK_AMOUNT = 21
  DEALER_HIT_MINIMUM = 17

  def initialize
    @deck = Deck.new
    @player = Player.new
    @dealer = Dealer.new
    @cash_pot = 500
    @bet = 0
  end

  def welcome_screen
    system "clear"
    puts " "
    puts "====================="
    puts "Welcome to Blackjack!"
    puts "====================="
    puts " "
  end

  def set_player_name
    puts "What's your name?"
    player.name = gets.chomp
  end

  def show_bet
    self.bet
  end

  def show_cash_pot
    self.cash_pot
  end
  

  def place_bet(show_cash_pot)
    puts "---"
    puts "The minimum bet is $5, and the maximum is $500."
    puts "Please choose a number between 5 and 500 (Numbers only, no '$' or decimals, please...)"
    puts "---"
    puts "  "
    puts "Place your bet. (You have \$#{cash_pot})!"
    self.bet = gets.chomp.to_i
    puts "#{player.name} bets \$#{self.bet}..."
  end

  def dealer_calls_no_more_bets
    puts "No more bets!"
    sleep 1.0
    system 'clear'
  end

  def card_deal_description
    sleep 0.5
    puts "#{player.name} receives first card."
    sleep 1.0
    puts "Dealer receives first card."
    sleep 1.0
    puts "#{player.name} receives second card."
    sleep 1.0
    puts "Dealer receives second card."
    sleep 1.0
    system 'clear'
  end

  def deal_cards
    dealer_calls_no_more_bets
    player.add_card(deck.deal_card)
    dealer.add_card(deck.deal_card)
    player.add_card(deck.deal_card)
    dealer.add_card(deck.deal_card)
    card_deal_description
  end
  
  def calculate_player_blackjack_cash_pot_balance
    self.cash_pot = show_cash_pot + calculate_player_blackjack_winnings_value
  end

  def calculate_dealer_blackjack_cash_pot_balance
    self.cash_pot = show_cash_pot - show_bet
  end

  def calculate_player_winning_cash_pot_balance
    self.cash_pot = show_cash_pot + show_bet
  end

  def calculate_player_losing_cash_pot_balance
    self.cash_pot = show_cash_pot - show_bet
  end

  def calculate_player_blackjack_winnings_value
    self.cash_pot = (show_bet / 2) + show_bet
  end

  def player_blackjack_message
    show_all_cards_at_end
    puts "=> Congratulations, #{player.name}! You hit Blackjack!"
    puts "You bet \$#{show_bet}."
    puts "You now have \$#{calculate_player_blackjack_cash_pot_balance}."
  end

  def dealer_blackjack_message
    show_all_cards_at_end    
    puts "=> Sorry, Dealer hit blackjack."
    puts "You bet \$#{show_bet}." 
    puts "You now have \$#{calculate_dealer_blackjack_cash_pot_balance}."
  end

  def player_high_score_message   show_all_cards_at_end
    puts "=> Congratulations, #{player.name}! You won!"
    puts " " 
    puts "You bet \$#{show_bet}." 
    puts "You now have \$#{calculate_player_winning_cash_pot_balance}."
  end

  def dealer_high_score_message
    show_all_cards_at_end
    puts "=> Sorry, Dealer wins."
    puts " " 
    puts "You bet \$#{show_bet}." 
    puts "You now have \$#{calculate_player_losing_cash_pot_balance}."
  end

  def player_busted_message
    show_all_cards_at_end
    puts "=> Sorry, #{player.name}, you busted."
    puts " " 
    puts "You bet \$#{show_bet}." 
    puts "You now have \$#{calculate_player_losing_cash_pot_balance}."
  end

  def dealer_busted_message
    show_all_cards_at_end
    puts "=> Dealer busted. #{player.name} wins!"
    puts " "
    puts "You bet \$#{show_bet}." 
    puts "You now have \$#{calculate_player_winning_cash_pot_balance}."
  end

  def push_message
    show_all_cards_at_end
    puts "=> We both got a #{player.total}. It's a push!"
    puts "Your bet will carry over to the next round..."
  end

  def blackjack_or_bust?(player_or_dealer)
    if player_or_dealer.total == BLACKJACK_AMOUNT
      if player_or_dealer.is_a?(Dealer)
        dealer_blackjack_message
      else
        player_blackjack_message
      end
      play_again?
    elsif player_or_dealer.is_busted?
      if player_or_dealer.is_a?(Dealer)
        dealer_busted_message
      else
        player_busted_message
      end
      play_again?
    end
  end

  def player_turn
    puts "=> #{player.name}'s turn."

    blackjack_or_bust?(player)

    while !player.is_busted?
      puts "What would you like to do? 1) hit 2) stand"
      hit_or_stand = gets.chomp

      if !['1', '2'].include?(hit_or_stand)
        puts "Error: you must enter 1 or 2"
        next
      end

      if hit_or_stand == '2'
        puts " "
        break
      end

      # Hit
      new_card = deck.deal_card
      puts " "
      puts "Dealing card to #{player.name}: #{new_card}"
      player.add_card(new_card)
      puts " " 
      puts "#{player.name}'s total is now: #{player.total}"

      blackjack_or_bust?(player)
    end
    puts "#{player.name} stands at #{player.total}."
    puts " "    
  end

  def show_all_cards_at_end
    system 'clear'
    player.show_hand
    dealer.show_hand
  end
  
  def main_game_play_sequence
    deal_cards
    player.show_hand
    dealer.show_upcard_only
    player_turn
    dealer_turn
    determine_winner
  end
  
  def dealer_turn
    puts "=> Dealer's turn."

    blackjack_or_bust?(dealer)
    while dealer.total < DEALER_HIT_MINIMUM
      new_card = deck.deal_card
      puts "Dealing card to dealer: #{new_card}"
      dealer.add_card(new_card)
      puts "Dealer total is now: #{dealer.total}"
      puts " "

      blackjack_or_bust?(dealer)
    end
    puts "Dealer stands at #{dealer.total}."
    puts " "
  end

  def determine_winner
    if player.total > dealer.total
      player_high_score_message
    elsif player.total < dealer.total
      dealer_high_score_message
    else
      push_message
      keep_playing_if_tied
    end
    play_again?
  end

  def play_again?
    puts ""
    puts "Would you like to play again? 1) yes 2) no"
    loop do
      continue_game = gets.chomp
      if continue_game == '1'
        puts "Starting new game..."
        sleep 1.0
        system 'clear'
        deck = Deck.new
        player.cards = []
        dealer.cards = []
        show_cash_pot
        keep_playing
      elsif continue_game == '2'
        puts "Thanks for playing!"
        sleep 4.0
        system 'clear'
        exit
      else
        puts "Error: you must enter 1 or 2"
      end
    end
  end

  def start
    welcome_screen
    set_player_name
    place_bet(show_cash_pot)
    main_game_play_sequence
  end

  def keep_playing
    place_bet(show_cash_pot)
    main_game_play_sequence
  end

  def keep_playing_if_tied
    sleep 2.0
    main_game_play_sequence
  end
end

game = Game.new
game.start

