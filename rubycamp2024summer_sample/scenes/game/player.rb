# Playerクラス（userクラスとcomputerクラスの基幹クラス）
class Player
  INITIAL_POINT = 50  # 初期ポイント

  HAND_LIMIT = 5      # 手札の上限

  attr_accessor :hand, :point

  # インスタンス変数の初期化
  def initialize
    @hand = []
    @point = INITIAL_POINT
  end

  protected

  # カードを捨てる（子クラスでオーバーライド定義）
  def trash_card; end
end
