require 'gosu'
class PokerGameWindow < Gosu::Window
  CARD_WIDTH = 50
  CARD_HEIGHT = 50

  def initialize(players)
    super 800, 600
      self.caption = 'Poker Game'
      @deck = Deck.new
      @players = players.map { |name| Player.new(name) }
      @players.each { |player| player.receive_hand(@deck.draw(5)) }
      load_card_images
      @player_positions = [[50, 50], [400, 50]]  # Simplistic positions for the players
      @selected_cards = []
      @current_player = @players.first
      @discarded_cards = []
  end
end

class Card
  # SUITS = ['Hearts', 'Diamonds', 'Clubs', 'Spades']
  # SUITS = ['hearts', 'diamonds', 'clubs', 'spades']
  SUITS = ['H', 'D', 'C', 'S']
  RANKS = ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K', '1']

  attr_reader :suit, :rank

  def initialize(rank, suit)
    @rank = rank
    @suit = suit
  end

  def to_s
    "#{rank} of #{suit}"
  end

  def value
    RANKS.index(rank) + 2
  end

  def image_path
    # "cards/#{rank}_of_#{suit}.png"
    "cards/#{suit}#{rank}.png"
  end
end

class Deck
  def initialize
    @cards = Card::SUITS.product(Card::RANKS).map { |suit, rank| Card.new(rank, suit) }.shuffle
  end

  def draw(count)
    @cards.pop(count)
  end

  def empty?
    @cards.empty?
  end
end

class Player
  attr_reader :hand

  def initialize(name)
    @name = name
    @hand = []
  end

  def receive_hand(cards)
    @hand = cards
  end

  def discard_card(card)
    @hand.delete(card)
  end

  def to_s
    @name
  end
end
def load_card_images
  @card_images = {}
  Card::SUITS.each do |suit|
    Card::RANKS.each do |rank|
      path = "cards/#{suit}#{rank}.png"
      begin
          @card_images["#{suit}#{rank}"] = Gosu::Image.new(path)
          rescue Gosu::Image::CannotLoadError => e
              puts "Erro ao carregar a imagem #{path}: #{e.message}"
      end
    end
  end
end

def draw
  @players.each_with_index do |player, index|
    draw_player_hand(player, @player_positions[index])
  end
end

def draw_player_hand(player, position)
  player.hand.each_with_index do |card, i|
    card_image = @card_images["#{card.suit}#{card.rank}"]
    x = position[0] + i * (CARD_WIDTH + 10)
    y = position[1]
    # Ajusta a escala para o tamanho desejado
    scale_x = CARD_WIDTH.to_f / card_image.width
    scale_y = CARD_HEIGHT.to_f / card_image.height
    card_image.draw(x, y, 0, scale_x, scale_y)

    if @selected_cards.include?(card)
      draw_card_border(x, y)
    end
  end
end

def draw_card_border(x, y)
  border_thickness = 3  # Espessura da borda
  Gosu.draw_line(x, y, Gosu::Color::RED, x + CARD_WIDTH, y, Gosu::Color::RED, border_thickness) # Topo
  Gosu.draw_line(x + CARD_WIDTH, y, Gosu::Color::RED, x + CARD_WIDTH, y + CARD_HEIGHT, Gosu::Color::RED, border_thickness) # Direita
  Gosu.draw_line(x + CARD_WIDTH, y + CARD_HEIGHT, Gosu::Color::RED, x, y + CARD_HEIGHT, Gosu::Color::RED, border_thickness) # Inferior
  Gosu.draw_line(x, y + CARD_HEIGHT, Gosu::Color::RED, x, y, Gosu::Color::RED, border_thickness) # Esquerda
end

def button_down(id)
  case id
  when Gosu::MS_LEFT
    x, y = mouse_x, mouse_y
    @players.first.hand.each do |card|
      card_x = @player_positions.first[0] + @players.first.hand.index(card) * (CARD_WIDTH + 10)
      card_y = @player_positions.first[1]
      if x.between?(card_x, card_x + CARD_WIDTH) && y.between?(card_y, card_y + CARD_HEIGHT)
        if @selected_cards.include?(card)
          @selected_cards.delete(card)
        else
          @selected_cards << card
        end
      end
    end
  end
end

def update
  if @selected_cards.any?
    if Gosu.button_down?(Gosu::KB_SPACE)
      @selected_cards.each do |card|
        @players.first.discard_card(card)
        @discarded_cards << card
      end
      @selected_cards.clear
      @players.first.receive_hand(@deck.draw(@selected_cards.size)) if @deck.empty?
    end
  end
end

# # ゲーム開始
window = MainWindow.new
window.show
