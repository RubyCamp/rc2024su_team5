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
          player.receive_card(@deck.shift)
        end
      end
      end

      def winner_check
        @players.each do |player|
          roles << @judge.judge(player)
        end

        @players[roles.index(roles.max)]
      end
    end
  end
end
