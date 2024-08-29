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

    @hand.each_with_index do |card, i|
      @hand.delete_at(i) if card_num[card.num - 1] == 1
    end
  end
end