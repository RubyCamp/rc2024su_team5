class Card
    attr_reader :suit, :rank
  
    RANKS = ['4', '5', '6', '7', 'Q', 'J', 'K', 'A', '2', '3']
    SUITS = ['Clubs', 'Diamonds', 'Hearts', 'Spades']
  
    def initialize(rank, suit)
      @rank = rank
      @suit = suit
    end
  
    def strength
      RANKS.index(rank)
    end
  
    def to_s
      "#{rank} of #{suit}"
    end
  end
  
  class Deck
    def initialize
      @cards = Card::RANKS.product(Card::SUITS).map do |rank, suit|
        Card.new(rank, suit)
      end.shuffle
    end
  
    def draw
      @cards.pop
    end
  end
  
  class Player
    attr_reader :name, :hand
  
    def initialize(name)
      @name = name
      @hand = []
    end
  
    def draw_card(deck)
      @hand << deck.draw
    end
  
    def play_card
      card = @hand.shift
      puts "#{name} plays #{card}"
      card
    end
  end
  
  class TrucoGame
    def initialize(player1, player2)
      @player1 = Player.new(player1)
      @player2 = Player.new(player2)
      @deck = Deck.new
      @player1_score = 0
      @player2_score = 0
    end
  
    def start
      deal_cards
      play_round
      display_winner
    end
  
    private
  
    def deal_cards
      3.times do
        @player1.draw_card(@deck)
        @player2.draw_card(@deck)
      end
    end
  
    def play_round
      3.times do |round|
        puts "Round #{round + 1}:"
        card1 = @player1.play_card
        card2 = @player2.play_card
  
        if card1.strength > card2.strength
          @player1_score += 1
          puts "#{@player1.name} wins the round!"
        elsif card1.strength < card2.strength
          @player2_score += 1
          puts "#{@player2.name} wins the round!"
        else
          puts "It's a tie!"
        end
      end
    end
  
    def display_winner
      puts "\nFinal Scores:"
      puts "#{@player1.name}: #{@player1_score}"
      puts "#{@player2.name}: #{@player2_score}"
  
      if @player1_score > @player2_score
        puts "#{@player1.name} wins the game!"
      elsif @player1_score < @player2_score
        puts "#{@player2.name} wins the game!"
      else
        puts "The game is a draw!"
      end
    end
  end
  
  # ゲームを開始する
  game = TrucoGame.new("Player 1", "Player 2")
  game.start
  