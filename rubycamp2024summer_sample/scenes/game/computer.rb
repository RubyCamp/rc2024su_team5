require_relative 'player'

class Computer < Player
  def initialize
    super
  end

  def trash_card
    dmp = @hand.map { |card| card.num }.tally
    trash_num = dmp.select { |_, v| v == 1 }

    @hand.each_with_index do |card, i|
      if trash_num.include?(card.num)
        @hand.delete_at(i)
        break
      end
    end
  end
end