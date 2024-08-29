require_relative 'card/base'
require_relative 'card/spade'
require_relative 'card/diamond'
require_relative 'card/heart'
require_relative 'card/club'
require_relative 'user'
require_relative 'computer'
require_relative 'referee'
require_relative 'role_judge'

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
        @deck = []                                             # 全てのカードを保持する配列
        @cleared = false                                       # ゲームクリアが成立したか否かを保持するフラグ
        @trashed = false                                       # カードを捨てたか否かを保持するフラグ
        @redrawed = false                                      # カードの再ドローが完了したか否かを保持するフラグ
        @trashed_com = false                                   # コンピューターがカードを捨てたか否かを保持するフラグ
        @redrawed_com = false                                  # コンピューターがカードを再ドローしたか否かを保持するフラグ
        @offset_mx = 0                                         # マウスドラッグ中のカーソル座標補正用変数（X成分用）
        @offset_my = 0                                         # マウスドラッグ中のカーソル座標補正用変数（Y成分用）

        @user = User.new                                       # ユーザーの情報を保持するインスタンス
        @computer = Computer.new                               # コンピュータの情報を保持するインスタンス
        @referee = Referee.new([@user, @computer])             # 審判の情報を保持するインスタンス
      end

      # 1フレーム分の更新処理
      def update(opt = {})
        # BGMをスタートする（未スタート時のみ）
        @bgm.play if @bgm && !@bgm.playing?

        # マウスの現在座標を変数化しておく
        mx = opt.key?(:mx) ? opt[:mx] : 0
        my = opt.key?(:my) ? opt[:my] : 0

        # ユーザーの手札のカードをクリックした場合、そのカードを捨てる
        @user.trash_card(mx, my) if key_push?(Gosu::MsLeft) && !@trashed

        # カードを捨て終わったら、フラグを立てる
        @trashed = true if key_push?(Gosu::KB_SPACE)

        # カードを捨てた後、再度カードを引く
        if @trashed && !@redrawed
          @referee.redraw(@user, Player::HAND_LIMIT - @user.hand.size)
          @redrawed = true
        end

        # コンピューターが手札を捨てる
        if @redrawed && !@trashed_com
          @computer.trash_card
          @trashed_com = true
        end

        # コンピューターがカードを捨てた後、再度カードを引く
        if @trashed_com && !@redrawed_com
          @referee.redraw(@computer, Player::HAND_LIMIT - @computer.hand.size)
          @redrawed_com = true
        end

        # ゲームクリアフラグが立ち、且つ画面への判定結果表示が完了済みの場合、エンディングシーンへ切り替えを行う
        transition(:ending) if @cleared
      end

      # 1フレーム分の描画処理
      def draw
        # 背景画像の描画
        @bg_img.draw(0, 0, 0)

        # カードの描画
        @deck.each(&:draw)

        # ユーザーの手札を横に並べて描画
        @user.hand.each_with_index do |card, i|
          card.x = 100 + i * 120
          card.y = 450
          card.open
          card.draw
        end

        # コンピューターの手札を横に並べて描画
        @computer.hand.each_with_index do |card, i|
          card.x = 100 + i * 120
          card.y = 100
          card.open
          card.draw
        end

        # ゲームクリア判定結果の表示
        if @redrawed_com && @redrawed
          clear_text = @referee.winner_check
          font = Gosu::Font.new(24, name: 'DelaGothicOne-Regular.ttf')
          font.draw_text(clear_text, 0, 0, 10, 3.0, 3.0, Gosu::Color::WHITE)
        end
      end
    end
  end
end
