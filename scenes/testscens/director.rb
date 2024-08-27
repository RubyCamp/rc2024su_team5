module Scenes
  module Testscens
    # タイトルシーンの担当ディレクタークラス
    class Director < DirectorBase
      SUIT_MARK_OFFSET_X = 5   # カードの種別マークのX方向表示位置（カードの左上からの相対値）
      SUIT_MARK_OFFSET_Y = 5   # カードの種別マークのY方向表示位置（カードの左上からの相対値）
      SCALE = 1 
      # コンストラクタ
      def initialize
        super
        @bg_img = Gosu::Image.new("images/bg_title.png", tileable: true)
        @card_foreground_img = Gosu::Image.new("images/card_foreground.png", tileable: true)    # カードの表面画像（数字がある側）
        @card_background_img = Gosu::Image.new("images/card_background.png", tileable: true) 
        @bgm = load_bgm("bgm1.mp3", 0.3)
        @number_font = Gosu::Font.new(80, name: DirectorBase::FONT_FILENAME)
        @suit_font = Gosu::Font.new(24, name: DirectorBase::FONT_FILENAME)

        # 山札を作成する
        @suits = ['♥', '♦', '♣', '♠']
        ranks = ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K', 'A']

        # 全てのカードを組み合わせた山札を作成する
        deck = @suits.product(ranks).map {|suit, rank| {suit: suit, rank: rank}}

        # 山札をシャッフルする
        deck.shuffle!

        # プレイヤーに5枚のカードを配布する
        @player_hand = deck.pop(5)

      end

      # 1フレーム分の更新処理
      def update(opt = {})
        # @bgm.play if @bgm && !@bgm.playing?
        # # スペースキー押下でゲーム本編シーンへ切り替えを行う
        # if key_push?(Gosu::KB_SPACE)
        #   transition(:game)
        #   @bgm.stop if @bgm && @bgm.playing?
        # end
      end

      # 1フレーム分の描画処理
      def draw
        @bg_img.draw(0, 0, 0)
        (0..4).each {|n| 
          draw_card(100*n,100,@player_hand[n][:rank], @player_hand[n][:suit],get_color(@player_hand[n][:suit]))
        }
        @card_background_img.draw(0,0,0)

        draw_text("Ruby合宿2024夏 Example Game", :center, 280, font: :title, color: :red)
        draw_text("Push SPACE Key to start", :center, 350)
      end

      def draw_card(x, y, cardword, suitmark, color)
        @card_foreground_img.draw(x,y,1)
        draw_number(x, y, cardword, color)
        draw_suit_mark(x, y, suitmark, color)
      end
      def draw_suit_mark(x, y, suitmark, color)
        @suit_font.draw_text(
          suitmark,
          x + SUIT_MARK_OFFSET_X,
          y + SUIT_MARK_OFFSET_Y,
          2,
          SCALE, SCALE,
          color)
      end

      # カードの番号の描画
      def draw_number(x, y, cardword, color)
        num_w = @number_font.text_width(cardword)
        num_h = @number_font.height
        num_x = x + (@card_foreground_img.width / 2) - (num_w / 2)
        num_y = y + (@card_foreground_img.height / 2) - (num_h / 2)
        @number_font.draw_text(cardword, num_x, num_y, 2, SCALE, SCALE, color)
      end
      def get_color(suit)
        if @suits.index(suit) == 0 || @suits.index(suit) == 1
          return Gosu::Color.argb(0xff_ff0000)
        else
          return Gosu::Color.argb(0xff_000000)
        end
      end
   end
  end
end