class CBuffer
  attr_accessor :raise_on_full

  class BufferFull < StandardError; end

  def initialize(capacity)
    @capacity = capacity
    @raise_on_full = false  
    @f = @b = @fc = 0
    @buffer = Array.new(capacity)
  end

  def get
    element = @buffer[@f]
    @buffer[@f] = nil
    @fc = @fc - 1
    @f = (@f + 1) % @capacity
    element
  end

  def put(element)
    raise BufferFull if full? && @raise_on_full
    @buffer[@b] = element
    @fc = @fc + 1
    @b = (@b + 1) % @capacity
  end

  def full?
    @f == @b && @fc != 0
  end

  def empty?
    @f == @b && @fc == 0
  end

  def size
    @capacity
  end

  def clear
    @buffer.clear
    @f = @b = @fc = 0
  end

  def elements
    @buffer.compact
  end
end
