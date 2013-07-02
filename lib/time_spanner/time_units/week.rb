module TimeSpanner
  module TimeUnits

    class Week < CalendarUnit

      def initialize
        super 6
      end


      private

      def calculate_amount
        amount  = ( ( to.to_datetime - from.to_datetime ) / 7 ).to_i
        @amount = at_amount( amount ) > to ? amount - 1 : amount
      end

      def at_amount amount
        ( from.to_datetime + amount * 7 ).to_time
      end

    end

  end
end
