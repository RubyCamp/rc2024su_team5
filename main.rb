require 'gosu'

require_relative 'scenes/manager'
require_relative 'scenes/director_base'
require_relative 'scenes/title/director'
require_relative 'scenes/game/director'
require_relative 'scenes/ending/director'
require_relative 'scenes/game_over/director'

# ゲームのメインウィンドウ（メインループ）用クラス
class MainWindow < Gosu::Window
  # 各種定数定義
  WIDTH = 800
  HEIGHT = 600
  FULL_SCREEN = false

  # コンストラクタ
  def initialize
    super WIDTH, HEIGHT, FULL_SCREEN
    self.caption = 'RubyCamp2024Summer team5'
  end

  # 1フレーム分の更新処理
  def update
  end

  # 1フレーム分の描画処理
  def draw
  end
end

# ゲーム開始
window = MainWindow.new
window.show
