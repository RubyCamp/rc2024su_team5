require_relative 'card/base'
require_relative 'card/spade'
require_relative 'card/diamond'
require_relative 'card/heart'
require_relative 'card/club'
require_relative 'player'
require_relative 'referee'
require_relative 'role_judge'

module Scenes
  module Game
    class Referee
      SUIT_AMOUNT = 13                  # 各マーク毎のカード枚数

      def initialize(players)
      @players = players
      @deck = []
      @judge = RoleJudge.new

      # 4種のカードについて、それぞれ13枚ずつ生成してデッキに追加する
      [
        Card::Spade,
        Card::Diamond,
        Card::Heart,
        Card::Club
      ].each do |klass|
        1.upto(SUIT_AMOUNT) do |num|
          @deck << klass.new(num, 0, 0, 0)
        end
      end

      # カードをシャッフルする
      @deck.shuffle!

      # プレイヤーにカードを配る
      @players.each do |player|
        Player::HAND_LIMIT.times do
          player.hand << @deck.shift
        end
      end
      end

      def winner_check
        @players.each do |player|
          roles << @judge.judge(player)
        end

        @players[roles.index(roles.max)]
      end

      def hand_ranking(hand)
        # カードの数値とスートを取得
        values = hand.map { |card| CARD_VALUES[card[0]] }.sort
        suits = hand.map { |card| card[1] }
      
        # 重複を調べる
        value_counts = values.tally.values
      
        # 役の判定
        if suits.uniq.size == 1 && values.each_cons(2).all? { |a, b| b == a + 1 }
          # 'ストレートフラッシュ'
        elsif value_counts == [4, 1]
          'フォーカード'
        elsif value_counts == [3, 2]
          'フルハウス'
        elsif suits.uniq.size == 1
          'フラッシュ'
        elsif values.each_cons(2).all? { |a, b| b == a + 1 }
          'ストレート'
        elsif value_counts == [3, 1, 1]
          'スリーカード'
        elsif value_counts.sort == [2, 2, 1]
          'ツーペア'
        elsif value_counts == [2, 1, 1, 1]
          'ワンペア'
        else
          'ハイカード'
        end
      end
    end
  end
end
