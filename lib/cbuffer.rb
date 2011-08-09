class CBuffer
  class BufferFull < StandardError; end

  def initialize(capacity)
    @capacity = capacity
    @raise_on_full = false  
    @f = @b = 0
    @buffer = Array.new(capacity)
  end

  def get
    element = @buffer[@b]
    @buffer[@b] = nil
    @b = (@b + 1) % @capacity
    element
  end

  def put(element)
    raise BufferFull if full?
    @buffer[@f] = element
    @f = (@f + 1) % @capacity
  end

  def full?
    @f == @b && @buffer[@f] != nil
  end

  def empty?
    @f == @b && @buffer[@f] == nil
  end

  def size
    @capacity
  end

  def clear
    @buffer = Array.new(@capacity)
    @f = @b = 0
  end
end
