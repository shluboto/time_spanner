require "test_helper"

module TimeSpanner
  module TimeUnits
    class MicrosecondTest < TestCase
      it "initializes" do
        microsecond = Microsecond.new

        assert microsecond.is_a?(TimeUnit)
        assert_equal 12, microsecond.position
        assert_equal :microseconds, microsecond.plural_name
      end

      it "calculates" do
        from = Time.now
        to = Time.at(from.to_r, 2.0)
        duration = to.to_r - from.to_r
        microsecond = Microsecond.new

        microsecond.calculate duration

        assert_equal 2, microsecond.amount
        assert_equal 0, microsecond.rest
      end

      it "calculates with rest (999 nanoseconds in seconds)" do
        from = Time.now
        target_micros = Time.at(from.to_r, 2.0)
        to = Time.at(target_micros.to_r, 0.999)
        duration = to.to_r - from.to_r
        microsecond = Microsecond.new

        microsecond.calculate duration

        assert_equal 2, microsecond.amount
        assert_equal Rational(8998192055486251, 9007199254740992000000), microsecond.rest
      end

      it "should not calculate amount of 2 although units equal" do
        from = Time.parse "2012-06-12 02:22:00"
        time_at_microseconds = Time.at(from.to_r, 2.0)
        to = Time.at time_at_microseconds.to_r, -0.001
        duration = to.to_r - from.to_r
        microsecond = Microsecond.new

        microsecond.calculate duration, to

        assert_equal 1, microsecond.amount
        assert microsecond.rest > 0
      end
    end
  end
end
