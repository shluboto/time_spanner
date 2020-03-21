module TimeSpanner
  module TimeUnits
    class Century < CalendarUnit
      def initialize
        super(2)
      end

      # Override!
      def plural_name
        :centuries
      end

      private

      def calculate_amount
        amount = (to.year - from.year) / 100
        @amount = at_amount(amount) > to ? amount - 1 : amount
      end

      def at_amount(amount)
        (from.to_datetime >> amount * 1200).to_time
      end
    end
  end
end
