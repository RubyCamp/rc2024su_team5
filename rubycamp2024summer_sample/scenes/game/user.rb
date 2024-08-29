require_relative 'player'

class User < Player
  def initialize
    super
  end

  def trash_card(mx, my)
    @hand.each_with_index do |card, i|
      if card.clicked?(mx, my)
        @hand.delete_at(i)
        break
      end
    end
  end
end
