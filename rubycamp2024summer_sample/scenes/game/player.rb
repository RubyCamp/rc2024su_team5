require 'gosu'

require_relative 'card/base'
require_relative 'card/club'
require_relative 'card/diamond'
require_relative 'card/heart'
require_relative 'card/spade'

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

  # カードを手札に加える
  def receive_card(card)
    @hand << card
  end

  protected

  # カードを捨てる（子クラスでオーバーライド定義）
  def trash_card; end
end
