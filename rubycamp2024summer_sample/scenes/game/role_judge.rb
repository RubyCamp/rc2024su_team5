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
    card_num = Array.new(13) { 0 }

    dmp = hand.map(&:num)
    dmp.each do |num|
      card_num[num - 1] += 1
    end

    card_num.sort.select { |num| num != 0 }
  end

  # 以下、各役の判定メソッド

  def straight_flush?(hand)
    flush?(hand) && straight?(hand)
  end

  def flush?(hand)
    hand.all? { |card| card.class == hand.first.class }
  end

  def straight?(hand)
    dmp = []
    hand.each do |card|
      dmp << card.num
    end

    dmp.sort

    return true if dmp == [1, 10, 11, 12, 13]

    dmp.each_cons(2).all? { |a, b| b == a + 1 }
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
