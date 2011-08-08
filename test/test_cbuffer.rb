require 'helper'

class TestCBuffer < Test::Unit::TestCase
  def test_simple
    b = CBuffer.new(7)
    assert b.empty?
    b.put "one"
    b.put "two"
    b.put "three"
    assert_equal "one", b.get
    b.put "four"
    assert_equal "two", b.get
    b.put "five"
    b.put "six"
    b.put "seven"
    assert_equal "three", b.get
    b.put "eight"
    b.put "nine"
    b.put nil 
    assert_equal "four", b.get
    assert_equal "five", b.get
    assert_equal "six", b.get
    assert_equal "seven", b.get
    assert_equal "eight", b.get
    assert_equal "nine", b.get
    assert_equal nil, b.get
    assert b.empty?
  end

  def test_buffer_overload
    b = CBuffer.new(3)
    b.raise_on_full = true;
    assert_raise(CBuffer::BufferFull) {
      b.put 1
      b.put 2
      b.put 3
      b.put 4
    }
  end

  def test_buffer_overload_over_time
    b = CBuffer.new(3)
    b.raise_on_full = true;
    assert_raise(CBuffer::BufferFull) {
      b.put 1
      b.put 2
      b.put 3
      b.put nil
    }
  end

  def test_clear_buffer
    b = CBuffer.new(3)
    b.put 1
    b.put 2
    b.put 3
    b.put nil
    b.put 4
    assert !b.empty?
    b.clear
    assert b.empty?
  end
end
