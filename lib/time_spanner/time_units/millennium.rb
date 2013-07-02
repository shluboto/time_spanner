module TimeSpanner
  module TimeUnits

    class Millennium < CalendarUnit

      def initialize
        super 1
      end


      private

      def calculate_amount
        amount  = ( to.year - from.year ) / 1000
        @amount = at_amount( amount ) > to ? amount - 1 : amount
      end

      def at_amount amount
        ( from.to_datetime >> amount * 12000 ).to_time
      end

    end

  end
end
