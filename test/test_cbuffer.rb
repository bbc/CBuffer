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
  end

  def test_circularness
    b = CBuffer.new(5)
    b.put 1 # [1,nil,nil,nil,nil]
    b.put 2 # [1,2,nil,nil,nil]
    b.put 3 # [1,2,3,nil,nil]
    b.get   # [nil,2,3,nil,nil]
    b.put 4 # [nil,2,3,4,nil]
    b.put 5 # [nil,2,3,4,5]
    b.put 6 # [6,2,3,4,5]
    assert_raise(CBuffer::BufferFull) {
      b.put(3)
    }
    b.get   # [6, nil, 3, 4, 5]
    b.put 7 # [6,7,3,4,5]
    assert_raise(CBuffer::BufferFull) {
      b.put(8)
    }
  end

  def test_buffer_overload
    b = CBuffer.new(3)
    assert_raise(CBuffer::BufferFull) {
      b.put(1)
      b.put(2)
      b.put(3)
      b.put(4)
    }
  end

  def test_buffer_overload_with_nil
    b = CBuffer.new(3)
    assert_raise(CBuffer::BufferFull) {
      b.put 1
      b.put 2
      b.put 3
      b.put nil
    }
  end
  
  def test_clear_buffer
    b = CBuffer.new(3)
    b.put(1)
    b.put(2)
    b.put(8)
    assert_raise(CBuffer::BufferFull) {
      b.put(nil)
    }
    b.clear
    assert b.empty?
  end

  def test_example_used_in_readme
    b = CBuffer.new(4)
    b.put({ :item => "one" })
    b.put({ :item => "two" })
    b.put({ :item => "three" })
    assert_equal({:item => "one"}, b.get)
    assert_equal({:item => "two"}, b.get)
    b.put(nil)
    b.put({ :item => "four" })
    assert_equal({:item => "three"}, b.get)
    assert_equal(nil, b.get)
    assert_equal({ :item => "four" }, b.get)
  end

  def test_again
    b = CBuffer.new(5)
    assert !b.put(1)
    assert !b.put(2)
    assert !b.put(3)
    assert !b.put(4)
    assert b.put(5)
    assert_equal 1, b.get
    assert_equal 2, b.get
    assert_equal 3, b.get
    assert_equal 4, b.get
    assert_equal 5, b.get
    assert_equal nil, b.get
    assert_equal nil, b.get
    assert !b.put(1)
    assert !b.put(2)
    assert !b.put(3)
    assert !b.put(4)
    assert_equal 1, b.get
    assert_equal 2, b.get
    assert_equal 3, b.get
    assert_equal 4, b.get
  end
end
