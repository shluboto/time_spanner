require "test_helper"

module TimeSpanner
  module TimeUnits
    class SecondTest < TestCase
      it "initializes" do
        second = Second.new

        assert second.is_a?(TimeUnit)
        assert_equal 10, second.position
        assert_equal :seconds, second.plural_name
      end

      it "calculates" do
        from = Time.parse("2012-12-14 00:00:00")
        to = Time.parse("2012-12-14 00:00:02")
        duration = to.to_r - from.to_r
        second = Second.new

        second.calculate duration

        assert_equal 2, second.amount
        assert_equal 0, second.rest
      end

      it "calculates with rest" do
        from = Time.now
        target_seconds = Time.at(from.to_r, 2000000.0)
        to = Time.at(target_seconds.to_r, 0.999)
        duration = to.to_r - from.to_r
        second = Second.new

        second.calculate duration

        assert_equal 2, second.amount
        assert_equal Rational(8998192055486251, 9007199254740992000000), second.rest
      end

      it "should not calculate amount of 2 although units equal" do
        from = Time.parse "2012-06-12 02:22:22"
        time_at_seconds = Time.parse "2012-06-12 02:22:24"
        to = Time.at time_at_seconds.to_r, -0.001
        duration = to.to_r - from.to_r
        second = Second.new

        second.calculate duration, to

        assert_equal 1, second.amount
        assert second.rest > 0
      end
    end
  end
end
