module TimeSpanner
  module TimeUnits
    class Decade < CalendarUnit
      def initialize
        super(3)
      end

      private

      def calculate_amount
        amount = (to.year - from.year) / 10
        @amount = at_amount(amount) > to ? amount - 1 : amount
      end

      def at_amount(amount)
        (from.to_datetime >> amount * 120).to_time
      end
    end
  end
end
