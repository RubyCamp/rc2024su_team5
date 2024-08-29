# 役判定クラス
class RoleJudge
  # 役判定
  def judge(hand)
    if straight_flush?(hand)
      8
    elsif four_of_a_kind?(hand)
      7
    elsif full_house?(hand)
      6
    elsif flush?(hand)
      5
    elsif straight?(hand)
      4
    elsif three_of_a_kind?(hand)
      3
    elsif two_pairs?(hand)
      2
    elsif one_pair?(hand)
      1
    else
      0
    end
  end

  # 各ランクの枚数を数える
  def count_rank(hand)
    hand.group_by(&:num).map { |_num, cards| cards.size }.sort!.compact!
  end

  # 以下、各役の判定メソッド

  def straight_flush?(hand)
    flush?(hand) && straight?(hand)
  end

  def flush?(hand)
    hand.all? { |card| card.class == hand.first.class }
  end

  def straight?(hand)
    return true if hand.map(&:num).sort == [1, 10, 11, 12, 13]

    hand.sort_by(&:num).each_cons(2).all? { |a, b| b.num - a.num == 1 }
  end

  def four_of_a_kind?(hand)
    count_rank(hand) == [1, 4]
  end

  def full_house?(hand)
    count_rank(hand) == [2, 3]
  end

  def three_of_a_kind?(hand)
    count_rank(hand) == [1, 1, 3]
  end

  def two_pairs?(hand)
    count_rank(hand) == [1, 2, 2]
  end

  def one_pair?(hand)
    count_rank(hand) == [1, 1, 1, 2]
  end
end
