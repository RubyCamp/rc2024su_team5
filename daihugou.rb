require 'gosu'

class GameWindow < Gosu::Window
  def initialize
    super 800, 600
    self.caption = "大富豪"

    @background_image = Gosu::Image.new("background.png", tileable: true)
    
    @deck = Deck.new
    @players = [Player.new("Player 1"), Player.new("Player 2"), Player.new("Player 3"), Player.new("Player 4")]

    deal_cards
  end

  def deal_cards
    @players.each do |player|
      player.hand = @deck.deal(13) # 各プレイヤーに13枚のカードを配る
    end
  end

  def update
    # ゲームロジックの更新
  end

  def draw
    @background_image.draw(0, 0, 0)
    @players.each_with_index do |player, index|
      player.draw_hand(50, 100 + index * 100)
    end
  end
end

class Card
  attr_reader :suit, :number

  def initialize(suit, number)
    @suit = suit
    @number = number
    @image = Gosu::Image.new("cards/#{suit}_#{number}.png")
  end

  def draw(x, y)
    @image.draw(x, y, 1)
  end
end

class Deck
  def initialize
    @cards = []

    [:hearts, :diamonds, :clubs, :spades].each do |suit|
      (1..13).each do |number|
        @cards << Card.new(suit, number)
      end
    end

    @cards.shuffle!
  end

  def deal(num)
    @cards.pop(num)
  end
end

class Player
  attr_accessor :hand

  def initialize(name)
    @name = name
    @hand = []
  end

  def draw_hand(x, y)
    @hand.each_with_index do |card, index|
      card.draw(x + index * 30, y)
    end
  end
end

# ゲームウィンドウの開始
window = GameWindow.new
window.show