class Referee
  def initialize
    super 800, 600,true
    self.caption = "トランプ表示"

    # 山札を作成する
    @suits = ['♥', '♦', '♣', '♠']
    @ranks = ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K', 'A']
    @deck = @suits.product(@ranks).map { |suit, rank| { suit: suit, rank: rank } }

    # 山札をシャッフルして5枚を配布
    @deck.shuffle!
    @players = []
    @players << User.new
    @players << Computer.new
    @players[0].hand = @deck.pop(5)
    @players[1].hand = @deck.pop(5)

    winner_check

    # カード画像の読み込み（背景用）
    @card_image = Gosu::Image.new("cards/card_foreground.png")
  end
  
  def winner_check
    #rolegudge
    player0 = @player[0].hand
    player1 = @plyaer[1].hand
  end
end