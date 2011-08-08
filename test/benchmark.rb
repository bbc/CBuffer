require_relative '../lib/cbuffer.rb'
require "benchmark"

# Comparing a circular buffer implimentation for creating
# a fixed size FIFO message queue to doing the same with 
# an Array. As you will see, the circualr buffer approach
# is much faster when it comes to writing.

SAMPLE_SIZE=10000

class ABuffer < Array
  def initialize(size)
    @ring_size = size
    super( size )
  end

  def put(element)
    if length == @ring_size
      shift
    end
    push element
  end

  def get(offset=0)
    self[ - 1 + offset ]
  end
end

def pushing(obj,txt)
  puts txt 
  Benchmark.bm(7) do |x|
    x.report("first:")   { (1..SAMPLE_SIZE).each { |i| obj.put(i) } }
    x.report("second:")  { (1..SAMPLE_SIZE).each { |i| obj.put(i) } }
    x.report("third:")   { (1..SAMPLE_SIZE).each { |i| obj.put(i) } }
  end
end

def pulling(obj,txt)
  puts txt
  Benchmark.bm(7) do |x|
    x.report("first:")   { (1..SAMPLE_SIZE).each { |i| obj.get } }
    x.report("second:")  { (1..SAMPLE_SIZE).each { |i| obj.get } }
    x.report("third:")   { (1..SAMPLE_SIZE).each { |i| obj.get } }
  end
end

def init
  ary = ABuffer.new(SAMPLE_SIZE)
  buf = CBuffer.new(SAMPLE_SIZE)

  pushing(ary,"Put: using Array Shift and Push")
  pushing(buf,"Put: using CBuffer")
  pulling(ary,"Get: using Array")
  pulling(buf,"Get: using CBuffer")
end

init
