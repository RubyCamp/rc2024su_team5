module Scenes
    module Title
        # タイトルシーンの担当ディレクタークラス
        class Director < DirectorBase
            def initialize
                super

                # 背景画像の読み込み
                @bg = Gosu::Image.new("images/bg1.jpg", tileable: true)

                # フォントの設定
                @font_title = Gosu::Font.new(80)
                @font_subtitle = Gosu::Font.new(35)
            end

            def update(opt = {})
                if key_push?(Gosu::KB_SPACE)
                    transition(:game)
                end
            end

            def draw
                @bg.draw(0, 0, 0)

                # テキストの描画
                draw_text("Poker Game", :center, 230, font: :title, color: :red, size: 200)
                @font_subtitle.draw_text("START (SPACE) ", 260, 340, 1, 1.0, 1.0, Gosu::Color::WHITE)
            end
        end
    end
end
