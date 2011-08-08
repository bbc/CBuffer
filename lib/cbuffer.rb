class CBuffer
  attr_accessor :raise_on_full

  class BufferFull < StandardError; end

  def initialize(capacity)
    @capacity = capacity
    @raise_on_full = false  
    @writePointer = @readPointer = 0
    @buffer = Array.new(capacity)
  end

  def get
    element = @buffer[@readPointer]
    @buffer[@readPointer] = nil
    @readPointer = @readPointer + 1
    @readPointer %= @capacity
    element
  end

  def put(element)
    raise BufferFull if full? && @raise_on_full
    @buffer[@writePointer] = element
    @writePointer = @writePointer + 1
    @writePointer %= @capacity
  end

  def full?
    (@writePointer + 1) % @capacity == @readPointer
  end

  def empty?
    @readPointer == @writePointer
  end

  def size
    @capacity
  end

  def clear
    @buffer.clear
    @writePointer = @readPointer = @fc = 0
  end

  def elements
    @buffer
  end
end
