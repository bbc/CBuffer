class CBuffer
  class BufferFull < StandardError; end

  def initialize(capacity)
    @capacity = capacity
    @raise_on_full = false  
    @f = @b = @fc = 0
    @buffer = Array.new(capacity)
  end

  def get
    return if empty?
    element = @buffer[@b]
    @buffer[@b] = nil
    @b = (@b + 1) % @capacity
    @fc = @fc - 1
    element
  end

  def put(element)
    raise BufferFull if full?
    @buffer[@f] = element
    @f = (@f + 1) % @capacity
    @fc = @fc + 1
    full?
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
    @buffer = Array.new(@capacity)
    @f = @b = @fc = 0
  end

  def to_s
    "<#{self.class} @size=#{@capacity}>"
  end
end
