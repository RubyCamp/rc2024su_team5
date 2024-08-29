require_relative 'player'

class Computer < Player
  def initialize
    super
  end

  def trash_card
    card_num = Array.new(13) { 0 }

    dmp = @hand.map(&:num)
    dmp.each do |num|
      card_num[num - 1] += 1
    end

    @hand.reject! { |card| card_num[card.num - 1] == 1 }
  end
end