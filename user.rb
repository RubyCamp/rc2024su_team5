require_relative 'player'

class User < Player
  def initialize
    super
  end
  def mouse_over_card?(index)
    mouse_x.between?(50 + index * 150, 50 + index * 150 + @player_images[index].width) &&
    mouse_y.between?(200, 200 + @player_images[index].height)
  end
  
  def trash_card
   
  end
end