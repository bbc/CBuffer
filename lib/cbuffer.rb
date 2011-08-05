class Cbuffer
  def initialize(capacity)
    @capacity = capacity
    @f = @b = 0
    @buffer = Array.new(capacity)
  end

  def get
    element = @buffer[@f]
    @buffer[@f] = nil
    @f = (@f + 1) % @capacity
    element
  end

  def put(element)
    @buffer[@b] = element
    @b = (@b + 1) % @capacity
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

  def elements
    @buffer.compact
  end
end
