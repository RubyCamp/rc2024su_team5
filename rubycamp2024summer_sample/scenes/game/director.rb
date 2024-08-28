require_relative 'card/base'
require_relative 'card/spade'
require_relative 'card/diamond'
require_relative 'card/heart'
require_relative 'card/club'

module Scenes
  module Game
    # ゲーム本編シーンの担当ディレクタークラス
    class Director < DirectorBase
      SUIT_AMOUNT = 13                  # 各マーク毎のカード枚数
      FPS = 30                          # 1秒間の表示フレーム数

      # コンストラクタ
      def initialize
        super
        # 画像オブジェクトの読み込み
        @bg_img = Gosu::Image.new("images/bg_game.png", tileable: true)
        @bgm = load_bgm("bgm2.mp3", 0.1)

        # 各種インスタンス変数の初期化
        @cards = []                                            # 全てのカードを保持する配列
        @cleared = false                                       # ゲームクリアが成立したか否かを保持するフラグ
        @drag_start_pos = nil                                  # マウスドラッグ用フラグ兼ドラッグ開始位置記憶用変数
        @offset_mx = 0                                         # マウスドラッグ中のカーソル座標補正用変数（X成分用）
        @offset_my = 0                                         # マウスドラッグ中のカーソル座標補正用変数（Y成分用）

        # 4種のカードについて、それぞれ13枚ずつランダムな座標にカードをばら撒く
        # NOTE: 各カードのZ値は、生成順に1から順にインクリメントして重ね合わせを表現する
        z = 1
        [
          Card::Spade,
          Card::Diamond,
          Card::Heart,
          Card::Club
        ].each do |klass|
          1.upto(SUIT_AMOUNT) do |num|
            x = 0
            y = 0
            @cards << klass.new(num, x, y, z)
            z += 1
          end
        end
      end

      # 1フレーム分の更新処理
      def update(opt = {})
        # BGMをスタートする（未スタート時のみ）
        @bgm.play if @bgm && !@bgm.playing?

        # マウスの現在座標を変数化しておく
        mx = opt.has_key?(:mx) ? opt[:mx] : 0
        my = opt.has_key?(:my) ? opt[:my] : 0

        # ゲームクリアフラグが立ち、且つ画面への判定結果表示が完了済みの場合、エンディングシーンへ切り替えを行う
        if @cleared && @message_display_frame_count == 0
          @bgm.stop if @bgm && @bgm.playing?
          transition(:ending)
        end
      end

      # 1フレーム分の描画処理
      def draw
        # 背景画像の描画
        @bg_img.draw(0, 0, 0)

        # カードの描画
        @cards.each(&:draw)
      end

    end
  end
end
