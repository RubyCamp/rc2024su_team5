# Playerクラス（userクラスとcomputerクラスの基幹クラス）
class Player
  INITIAL_POINT = 50  # 初期ポイント
  HANDS_LIMIT = 5     # 手札の上限

  attr_reader :hands, :point

  # インスタンス変数の初期化
  def initialize
    @hands = []
    @point = INITIAL_POINT
  end

  private

  # 手札を初期化
  def initialize_hands
    HANDS_LIMIT.times { @hands << Referee.draw_from_deck }
  end

  # カードを引く
  def draw_card(draw_times)
    draw_times.times { @hands << Referee.draw_from_deck }
  end

  protected

  # カードを捨てる（子クラスでオーバーライド定義）
  def trash_card; end
end
