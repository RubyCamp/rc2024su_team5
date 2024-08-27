require 'gosu'

class Card
  attr_reader :rank, :suit, :image

  def initialize(rank, suit, image)
    @rank = rank
    @suit = suit
    @image = image
  end

  def to_s
    "#{@rank} of #{@suit}"
  end

  def draw(x, y)
    @image.draw(x, y, 1)
  end
end

class Deck
  SUITS = ['Hearts', 'Diamonds', 'Clubs', 'Spades']
  RANKS = ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K', 'A']

  def initialize
    @cards = RANKS.product(SUITS).map do |rank, suit|
      image = Gosu::Image.new("media/#{rank}_of_#{suit.downcase}.png")
      Card.new(rank, suit, image)
    end
    shuffle!
  end

  def shuffle!
    @cards.shuffle!
  end

  def draw
    @cards.pop
  end
end

class Player
  attr_reader :hand

  def initialize
    @hand = []
  end

  def draw_card(deck)
    @hand << deck.draw
  end

  def draw_hand
    @hand.each_with_index do |card, index|
      card.draw(50 + index * 100, 300) # カードを横に並べて描画
    end
  end
end

class PokerGame < Gosu::Window
  def initialize
    super 640, 480
    self.caption = "Poker Game"
    @deck = Deck.new
    @player = Player.new
    @font = Gosu::Font.new(20)
  end

  def draw
    @player.draw_hand
    @font.draw_text("Press SPACE to draw cards", 10, 10, 1)
  end

  def update
    # ゲームのロジックをここに実装
  end

  def button_down(id)
    if id == Gosu::KbSpace
      @player.draw_card(@deck) if @player.hand.size < 5 # 5 枚までドロー可能
    end
  end
end

PokerGame.new.show
