#!/usr/bin/env ruby

require 'pry'

class Deck

  SUITS = ['♠', '♣', '♥', '♦']
  VALUES = ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K', 'A']

  def initialize
    @deck = []

    SUITS.each do |suit|
      VALUES.each do |value|
        @deck.push(value + suit)
      end
    end

    @deck.shuffle!
  end

  def deal_card
    @deck.pop
  end

end

class Card

  def initialize(suit, value)



class Blackjack


  def initialize
    @@player_hand ||= []
    @@dealer_hand ||= []
    @deck = Deck.new
  end

  #Deals card to either Player or Dealer
  def deal_to(hand, its_players_turn)

    card = @deck.deal_card
    hand << card

      if its_players_turn
        puts "\n***You got a #{card} !***"
      else
        puts "***Dealer got a #{card} !***"
      end
  end

  #Displays hand
  def show_hand

    "\n**************************************\nYour hand: #{@@player_hand.join(' | ')}  *** Your total: #{calculate_score(@@player_hand)}
    \n**************************************\nDealer's hand: #{@@dealer_hand.join(' | ')}  *** Dealer's total: #{calculate_score(@@dealer_hand)}\n\n"
  end

  #Calculates the best score for Player and Dealer
  def calculate_score(hand)

    scores = [0]

    hand.each do |card|
      value = card.chop

        if ['J','Q','K'].include?(value)
          scores = scores.map { |point| point + 10 }
        elsif value == 'A'
          scores_as_one = scores.map { |point| point + 1 }
          scores_as_eleven = scores.map { |point| point + 11 }
          scores = scores_as_one + scores_as_eleven
        else
          scores = scores.map { |point| point + value.to_i }
        end
    end

    good_scores = scores.select { |point| point <= 21 }

    if good_scores.any?
      good_scores.max   # Return the highest score that isn't a bust
    else
      scores.min        # Otherwise return the lowest bust score
    end
  end

  #Checks to see if Player or Dealer busted
  def check_bust(hand, its_players_turn)

    if hand > 21
      if its_players_turn
        puts "You bust! Game over, try again!"
        exit
      else
        puts "Dealer busts! You win!"
        exit
      end
    end
  end

  #Checks initial hand for 21
  def check_initial_hand_for_21

    if calculate_score(@@dealer_hand) == 21 && calculate_score(@@player_hand) == 21
      puts "You got lucky, but Dealer is equally as lucky. Push!"
      exit
    elsif calculate_score(@@dealer_hand) == 21
      puts "Dealer got lucky with 21! Sorry!"
      exit
    elsif calculate_score(@@player_hand) == 21
      puts "Nice! 21 on the deal. Lucky you!"
      exit
    end
  end

  #Checks winner based on relative scores between Player and Dealer
  def check_winner

    if calculate_score(@@dealer_hand) > calculate_score(@@player_hand)
      puts "Dealer wins! Try again!"
      exit
    elsif calculate_score(@@dealer_hand) < calculate_score(@@player_hand)
      puts "You win! Congrats!"
      exit
    else
      puts "It's a push! No winner!"
      exit
    end
  end

  #Starts Player's turn
  def players_turn(its_players_turn)

    while its_players_turn

      puts "Would you like to (h)it or (s)tay? "
      action = gets.chomp.downcase

      if action == 'h'
        deal_to(@@player_hand, true)
        puts show_hand
        check_bust(calculate_score(@@player_hand), true)
        players_turn(true)
      elsif action == 's'
        players_turn(false)
      else
        players_turn(true)
      end
    end

  #Dealer's turn once Player stays
    while true

      if calculate_score(@@dealer_hand) < 17 || calculate_score(@@dealer_hand) < calculate_score(@@player_hand)
        deal_to(@@dealer_hand, false)
        puts show_hand
        check_bust(calculate_score(@@dealer_hand), false)
        players_turn(false)
      else
        check_winner
      end
    end
  end

  #Deal initial cards to player and dealer
  def deal_two_cards

    puts "\nDealer deals some cards to you and herself:\n"

    2.times do
      deal_to(@@player_hand, true)
      deal_to(@@dealer_hand, false)
    end
  end

  #Start game
  def start

    puts "\n
                ²²²²²²  ²        ²²²²²   ²²²²²² ²   ²  ²²²²²²²  ²²²²²   ²²²²²² ²   ²
                ²     ² ²       ²     ² ²       ²  ²      ²    ²     ² ²       ²  ²
                ²     ² ²       ²     ² ²       ² ²       ²    ²     ² ²       ² ²
                ²²²²²²  ²       ²²²²²²² ²       ²²        ²    ²²²²²²² ²       ²²
                ²     ² ²       ²     ² ²       ² ²       ²    ²     ² ²       ² ²
                ²     ² ²       ²     ² ²       ²  ²      ²    ²     ² ²       ²  ²
                ²²²²²²  ²²²²²²² ²     ²  ²²²²²² ²   ²  ²²²²    ²     ²  ²²²²²² ²   ²

                ASCII art by Mathew Brenaman
                http://www.o-bizz.de/qbdown/qbcom/files/blackj.bas
                Game coded by Kevin Quach                                              \n"

    deal_two_cards
    puts show_hand
    check_initial_hand_for_21
    players_turn(true)
  end

end

new_game = Blackjack.new
new_game.start
