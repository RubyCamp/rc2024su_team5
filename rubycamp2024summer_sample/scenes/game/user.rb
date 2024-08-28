require 'gosu'

require_relative 'player'
require_relative 'card/base'
require_relative 'card/club'
require_relative 'card/diamond'
require_relative 'card/heart'
require_relative 'card/spade'

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
