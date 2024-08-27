# 山札を作成する
suits = ['ハート', 'ダイヤ', 'クラブ', 'スペード']
ranks = ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K', 'A']

# 全てのカードを組み合わせた山札を作成する
deck = suits.product(ranks).map { |suit, rank| "#{suit}の#{rank}" }

# 山札をシャッフルする
deck.shuffle!

# プレイヤーに5枚のカードを配布する
player_hand = deck.pop(5)

# プレイヤーの手札を表示する
puts "プレイヤーの手札: #{player_hand.join(', ')}"

# 残りの山札を表示する
puts "残りの山札: #{deck.join(', ')}"
