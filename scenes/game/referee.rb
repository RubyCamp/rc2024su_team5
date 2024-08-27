module Scenes
  module Game
    class Referee
      def judge_role(hand)
        if royal_straight_flush?(hand)
          return :royal_straight_flush
        elsif straight_flush?(hand)
          return :straight_flush
        elsif four_card?(hand)
          return :four_card
        elsif full_house?(hand)
          return :full_house
        elsif flush?(hand)
          return :flush
        elsif straight?(hand)
          return :straight
        elsif three_card?(hand)
          return :three_card
        elsif two_pair?(hand)
          return :two_pair
        elsif one_pair?(hand)
          return :one_pair
        else
          return :high_card
        end
      end

      private

      def royal_straight_flush?(hand)
        hand_nums = hand.map(&:number)
        hand_nums.sort == [10, 11, 12, 13, 14] && flush?(hand)
      end

      def straight_flush?(hand)
        straight?(hand) && flush?(hand)
      end

      def four_card?(hand)
        hand_nums = hand.map(&:number)
        hand_nums.any? { |num| hand_nums.count(num) == 4 }
      end

      def full_house?(hand)
        hand_nums = hand.map(&:number)
        hand_nums.uniq.size == 2 && three_card?(hand)
      end

      def flush?(hand)
        hand_suits = hand.map(&:suit)
        hand_suits.uniq.size == 1
      end

      def straight?(hand)
        hand_nums = hand.map(&:number)
        if [[2, 11, 12, 13, 14], [2, 3, 12, 13, 14], [2, 3, 4, 13, 14], [2, 3, 4, 5, 14]].any? { |special| special == hand_nums.sort }
          return true
        end

        hand_nums.sort.each_cons(2).all? { |a, b| b == a + 1 }
      end

      def three_card?(hand)
        hand_nums = hand.map(&:number)
        hand_nums.any? { |num| hand_nums.count(num) == 3 }
      end

      def two_pair?(hand)
        hand_nums = hand.map(&:number)
        hand_nums.uniq.size == 3 && hand_nums.any? { |num| hand_nums.count(num) == 2 }
      end

      def one_pair?(hand)
        hand_nums = hand.map(&:number)
        hand_nums.uniq.size == 4
      end
    end
  end
end
