require 'gosu'
require_relative 'player'


class User < Player
  def initialize
    super
  end

   # カード画像の読み込み（背景用）
   @player_images = Gosu::Image.new("cards/card_foreground.png")

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
  
  def trash_card
   # 指定されたカードを捨てる
   @hand.delete_at(index)
   @player_images.delete_at(index)
   puts "カードを捨てました: #{@hand}"
  end
  
end