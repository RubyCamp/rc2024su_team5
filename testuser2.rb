require 'gosu'

class CardGameWindow < Gosu::Window
  def initialize
    super 800, 600,true
    self.caption = "カードゲーム"

    # 山札を作成する
    suits = ['H', 'D', 'C', 'S']
    ranks = ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K', '1']
    
    @deck = suits.product(ranks).map { |suit, rank| "#{suit}#{rank}" }
    
    # 山札をシャッフルする
    @deck.shuffle!
    
    # プレイヤーに5枚のカードを配布する
    @player_hand = @deck.pop(5)
    
    # プレイヤーの手札を画像として読み込む
    @player_images = @player_hand.map do |card|
      Gosu::Image.new("cards/#{card}.png")
    end
  end

  def draw
    # プレイヤーの手札を描画する
    @player_images.each_with_index do |image, index|
      image.draw(50 + index * 150, 200, 0)
    end
  end

  def button_down(id)
    if id == Gosu::MsLeft
      # マウスがクリックされた時の処理
      @player_images.each_with_index do |image, index|
        if mouse_over_card?(index)
          discard_card(index)
          break
        end
      end
    end
  end

  def mouse_over_card?(index)
    mouse_x.between?(50 + index * 150, 50 + index * 150 + @player_images[index].width) &&
    mouse_y.between?(200, 200 + @player_images[index].height)
  end

  def discard_card(index)
    # 指定されたカードを捨てる
    @player_hand.delete_at(index)
    @player_images.delete_at(index)
    puts "カードを捨てました: #{@player_hand}"
  end
end

# ゲームウィンドウを作成し、開始する
window = CardGameWindow.new
window.show