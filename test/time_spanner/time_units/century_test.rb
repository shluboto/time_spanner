require "test_helper"

module TimeSpanner
  module TimeUnits
    class CenturyTest < TestCase
      it "initializes" do
        century = Century.new

        assert century.is_a?(CalendarUnit)
        assert_equal 2, century.position
        assert_equal :centuries, century.plural_name
      end

      it "calculates without rest" do
        from = Time.parse("2013-04-01 00:00:00")
        to = Time.parse("2213-04-01 00:00:00")
        duration = to.to_r - from.to_r
        century = Century.new

        century.calculate duration, to

        assert_equal 2, century.amount
        assert_equal 0, century.rest
      end

      it "calculates with rest (1 day in seconds)" do
        from = Time.parse("2013-01-01 00:00:00")
        to = Time.parse("2213-01-02 00:00:00")
        duration = to.to_r - from.to_r
        century = Century.new

        century.calculate duration, to

        assert_equal 2, century.amount
        assert_equal 86400, century.rest
      end

      it "should not calculate amount of 2 although units equal" do
        from = Time.parse "2012-06-12 00:00:00"
        time_at_centuries = Time.parse "2212-06-12 00:00:00"
        to = Time.at time_at_centuries.to_r, -0.001
        duration = to.to_r - from.to_r
        century = Century.new

        century.calculate duration, to

        assert_equal 1, century.amount
        assert century.rest > 0
      end
    end
  end
end
