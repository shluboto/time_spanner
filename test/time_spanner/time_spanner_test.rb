require "test_helper"

module TimeSpanner
  class TimeSpannerTest < TestCase
    include Errors

    it "creates a span instance" do
      from = Time.now
      to = from + 1
      span = TimeSpan.new(from, to)

      assert span.is_a?(TimeSpan)
      assert span.is_a?(Hash)
    end

    it "ensures converting to Time" do
      InvalidClass = Class.new {
        def to_time
          false
        end
      }

      assert_raises InvalidClassError do
        TimeSpan.new(InvalidClass.new, InvalidClass.new)
      end
    end
  end
end
