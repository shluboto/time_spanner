module TimeSpanner
  module TimeUnits

    class Year < CalendarUnit

      def initialize
        super 4
      end


      private

      def calculate_amount
        amount  = to.year - from.year
        @amount = at_amount( amount ) > to ? amount - 1 : amount
      end

      def at_amount amount
        ( from.to_datetime >> amount * 12 ).to_time
      end

    end

  end
end
