require "test_helper"

module TimeSpanner
  module TimeUnits
    class HourTest < TestCase
      it "initializes" do
        hour = Hour.new

        assert hour.is_a?(TimeUnit)
        assert_equal 8, hour.position
        assert_equal :hours, hour.plural_name
      end

      it "calculates without rest" do
        from = Time.parse("2013-04-03 00:00:00")
        to = Time.parse("2013-04-03 02:00:00")
        duration = to.to_r - from.to_r
        hour = Hour.new

        hour.calculate duration

        assert_equal 2, hour.amount
        assert_equal 0, hour.rest
      end

      it "calculates with rest (999 Nanoseconds in seconds)" do
        from = Time.parse("2013-04-03 00:00:00")
        target_hours = Time.parse("2013-04-03 02:00:00")
        to = Time.at(target_hours.to_r, 0.999)
        duration = to.to_r - from.to_r
        hour = Hour.new

        hour.calculate duration

        assert_equal 2, hour.amount
        assert_equal Rational(8998192055486251, 9007199254740992000000), hour.rest
      end

      it "should not calculate amount of 2 although units equal" do
        from = Time.parse "2012-06-12 02:22:00"
        time_at_hours = Time.parse "2012-06-12 04:22:00"
        to = Time.at time_at_hours.to_r, -0.001
        duration = to.to_r - from.to_r
        hour = Hour.new

        hour.calculate duration, to

        assert_equal 1, hour.amount
        assert hour.rest > 0
      end
    end
  end
end
