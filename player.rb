require 'gosu'
class Base
  @@card_foreground_img = Gosu::Image.new("images/card_foreground.png", tileable: true)    # カードの表面画像（数字がある側）
  @@card_background_img = Gosu::Image.new("images/card_background.png", tileable: true)    # カードの裏面画像
  @@suit_font = Gosu::Font.new(24, name: DirectorBase::FONT_FILENAME)                      # カードのマーク描画用フォント
  @@number_font = Gosu::Font.new(80, name: DirectorBase::FONT_FILENAME)                    # カードの数字描画用フォント

  WIDTH = 96               # カード横幅（px）
  HEIGHT = 128             # カード高さ（px）
  SUIT_MARK_OFFSET_X = 5   # カードの種別マークのX方向表示位置（カードの左上からの相対値）
  SUIT_MARK_OFFSET_Y = 5   # カードの種別マークのY方向表示位置（カードの左上からの相対値）
  SCALE = 1                # 描画時の表示倍率

  # カードを画面に描画する
  def draw
    if @reversed
      draw_background
    else
      draw_foreground
    end
  end
  private

  # カードの表側の描画
  def draw_foreground
    @@card_foreground_img.draw(self.x, self.y, self.z)
    draw_suit_mark
    draw_number
  end

  # カードの裏側の描画
  def draw_background
    @@card_background_img.draw(self.x, self.y, self.z)
  end

  # カードの種別マーク（Suit）の描画
  def draw_suit_mark
    @@suit_font.draw_text(
      self.class::SUIT_MARK,
      self.x + SUIT_MARK_OFFSET_X,
      self.y + SUIT_MARK_OFFSET_Y,
      self.z,
      SCALE, SCALE,
      self.class::SUIT_COLOR)
  end

  # カードの番号の描画
  def draw_number
    num_x = self.x + (@@card_foreground_img.width / 2) - (@num_w / 2)
    num_y = self.y + (@@card_foreground_img.height / 2) - (@num_h / 2)
    @@number_font.draw_text(@number_mark, num_x, num_y, self.z, SCALE, SCALE, self.class::NUMBER_COLOR)
  end

  # カードの数字の表示上の文字を取得する
  def get_number_mark
    case self.num
    when 1
      return "A"
    when 11
      return "J"
    when 12
      return "Q"
    when 13
      return "K"
    else
      return self.num.to_s
    end
  end
end