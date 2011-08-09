require_relative '../lib/cbuffer.rb'
require "benchmark"

# Comparing a circular buffer implimentation for creating
# a fixed size FIFO message queue to doing the same with 
# an Array. As you can see, the circualr buffer approach
# is much faster when it comes to writing to the queue.

#                     user     system      total        real
#Put: Array       0.480000   0.010000   0.490000 (  0.488787)
#Put: CBuffer     0.010000   0.000000   0.010000 (  0.009931)
#                     user     system      total        real
#Get: Array       0.010000   0.000000   0.010000 (  0.004768)
#Get: CBuffer     0.010000   0.000000   0.010000 (  0.007814)

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
    self[ -1 + offset ]
  end
end

def pushing
  ary = ABuffer.new(SAMPLE_SIZE)
  buf = CBuffer.new(SAMPLE_SIZE)

  Benchmark.bm(15) do |x|
    x.report("Put: Array")   { (1..SAMPLE_SIZE).each { |i| ary.put(i) } }
    x.report("Put: CBuffer") { (1..SAMPLE_SIZE).each { |i| buf.put(i) } }
  end
end

def pulling
  ary = ABuffer.new(SAMPLE_SIZE)
  (1..SAMPLE_SIZE).each { |i| ary.put(i) }
  buf = CBuffer.new(SAMPLE_SIZE)
  (1..SAMPLE_SIZE).each { |i| buf.put(i) }

  Benchmark.bm(15) do |x|
    x.report("Get: Array")   { (1..SAMPLE_SIZE).each { |i| ary.get } }
    x.report("Get: CBuffer") { (1..SAMPLE_SIZE).each { |i| buf.get } }
  end
end

def init
  pushing
  pulling
end

init
