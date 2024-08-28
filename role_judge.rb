class RoleJudge
  def initialize
  end

  def judge(hand)
    @hand = hand

    if royal_straight_flush?
      :royal_straight_flush
    elsif straight_flush?
      :straight_flush
    elsif four_card?
      :four_card
    elsif full_house?
      :full_house
    elsif flush?
      :flush
    elsif straight?
      :straight
    elsif three_card?
      :three_card
    elsif two_pair?
      :two_pair
    elsif one_pair?
      :one_pair
    else
      :high_card
    end
  end

  private

  def royal_straight_flush?
    @hand.sort!
    @hand.map(&:suit).uniq.size == 1 && @hand.map(&:number) == [1, 10, 11, 12, 13]
  end

  def straight_flush?
    flush? && straight?
  end

  def four_card?
    @hand.group_by(&:number).values.map(&:size).include?(4)
  end

  def full_house?
    @hand.group_by(&:number).values.map(&:size).sort == [2, 3]
  end

  def flush?
    @hand.map(&:suit).uniq.size == 1
  end

  def straight?
    @hand.sort!
    true if 
    @hand.each_cons(2).all? { |a, b| a.number + 1 == b.number }
  end

  def three_card?
    @hand.group_by(&:number).values.map(&:size).include?(3)
  end

  def two_pair?
    @hand.group_by(&:number).values.map(&:size).count(2) == 2
  end

  def one_pair?
    @hand.group_by(&:number).values.map(&:size).include?(2)
  end
end