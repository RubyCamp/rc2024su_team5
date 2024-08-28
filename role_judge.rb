# 役判定クラス
class RoleJudge
  # コンストラクタ
  def initialize(players)
    @players = players
  end

  # 役判定
  def judge
    @players.each do |player|
      if player.hand.straight_flush?
        :straight_flush
      elsif player.hand.four_of_a_kind?
        :four_of_a_kind
      elsif player.hand.full_house?
        :full_house
      elsif player.hand.flush?
        :flush
      elsif player.hand.straight?
        :straight
      elsif player.hand.three_of_a_kind?
        :three_of_a_kind
      elsif player.hand.two_pairs?
        :two_pairs
      elsif player.hand.one_pair?
        :one_pair
      else
        :high_card
      end
    end
  end

  # 以下、各役の判定メソッド
  private

  def straight_flush?(hand)
    flush?(hand) && straight?(hand)
  end

  def flush?(hand)
    hand.all? { |card| card.suit == hand.first.suit }
  end

  def straight?(hand)
    return true if hand.map(&:rank).sort == [1, 10, 11, 12, 13]

    hand.sort_by(&:rank).each_cons(2).all? { |a, b| b.rank - a.rank == 1 }
  end

  def count_rank(hand)
    hand.group_by(&:rank).map { |rank, cards| cards.size }.sort
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