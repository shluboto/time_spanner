require "test_helper"

module TimeSpanner
  module TimeUnits
    class MillisecondTest < TestCase
      it "initializes" do
        millisecond = Millisecond.new

        assert millisecond.is_a?(TimeUnit)
        assert_equal 11, millisecond.position
        assert_equal :milliseconds, millisecond.plural_name
      end

      it "calculates" do
        from = Time.now
        to = Time.at(from.to_r, 2000.0)
        duration = to.to_r - from.to_r
        millisecond = Millisecond.new

        millisecond.calculate duration

        assert_equal 2, millisecond.amount
        assert_equal 0, millisecond.rest
      end

      it "calculates with rest (999 nanoseconds in seconds)" do
        from = Time.now
        target_millis = Time.at(from.to_r, 2000.0)
        to = Time.at(target_millis.to_r, 0.999)
        duration = to.to_r - from.to_r
        millisecond = Millisecond.new

        millisecond.calculate duration

        assert_equal 2, millisecond.amount
        assert_equal Rational(8998192055486251, 9007199254740992000000), millisecond.rest
      end

      it "should not calculate amount of 2 although units equal" do
        from = Time.parse "2012-06-12 02:22:00"
        time_at_milliseconds = Time.at(from.to_r, 2000.0)
        to = Time.at time_at_milliseconds.to_r, -0.001
        duration = to.to_r - from.to_r
        millisecond = Millisecond.new

        millisecond.calculate duration, to

        assert_equal 1, millisecond.amount
        assert millisecond.rest > 0
      end
    end
  end
end
