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

  def trash_card
    @hand.delete_if { |card| card.clicked?(@mouse_x, @mouse_y) }
  end
end