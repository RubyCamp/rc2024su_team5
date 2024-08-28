# Playerクラス（userクラスとcomputerクラスの基幹クラス）
class Player
  INITIAL_POINT = 50  # 初期ポイント
  HAND_LIMIT = 5      # 手札の上限

  attr_reader :hand, :point

  # インスタンス変数の初期化
  def initialize
    @hand = []
    @point = INITIAL_POINT
  end

  private

  # 手札を初期化
  def initialize_hand(referee)
    HAND_LIMIT.times { @hands << referee.draw_from_deck }
  end

  # カードを引く
  def draw_card(referee, draw_times)
    draw_times.times { @hands << referee.draw_from_deck }
  end

  protected

  # カードを捨てる（子クラスでオーバーライド定義）
  def trash_card; end
end
