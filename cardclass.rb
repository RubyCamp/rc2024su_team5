require 'gosu'
require_relative 'player'


class CardGameWindow < Gosu::Window 
  def initialize
    super 800, 600,true
    self.caption = "トランプ表示"

    # 山札を作成する
    @suits = ['♥', '♦', '♣', '♠']
    @ranks = ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K', 'A']
    @deck = @suits.product(@ranks).map { |suit, rank| { suit: suit, rank: rank } }

    # 山札をシャッフルして5枚を配布
    @deck.shuffle!
    @player_hand = @deck.pop(5)

    # カード画像の読み込み（背景用）
    @card_image = Gosu::Image.new("cards/card_foreground.png")
    
    # テキスト用のフォントを設定
    @font = Gosu::Font.new(40)
  end

  def draw
    # プレイヤーの手札を描画する
    @player_hand.each_with_index do |card, index|
      x = 50 + index * 150
      y = 200
      # カードの画像を描画
      @card_image.draw(x, y, 0)
      # 画像の上にランクとスートを描画
      @font.draw_text(card[:rank], x + 20, y + 10, 1, 1.0, 1.0, Gosu::Color::BLACK)
      @font.draw_text(card[:suit], x + 20, y + 60, 1, 1.0, 1.0, Gosu::Color::BLACK)
    end
  end

  def button_down(id)
    if id == Gosu::MsLeft
      # マウスの左クリックが押された時
      @player_hand.each_with_index do |card, index|
        if mouse_over_card?(index)
          discard_card(index)
          break
        end
      end
    end
  end

  def mouse_over_card?(index)
    # カードの領域内にマウスカーソルがあるかをチェック
    x = 50 + index * 150
    y = 200
    mouse_x.between?(x, x + @card_image.width) && mouse_y.between?(y, y + @card_image.height)
  end

  def discard_card(index)
    # 指定されたカードを手札から捨てる
    @player_hand.delete_at(index)
    # puts "カードを捨てました: #{@player_hand}"
  end
end

# ゲームウィンドウを作成し、開始する
window = CardGameWindow.new
window.show