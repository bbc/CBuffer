require_relative '../lib/cbuffer.rb'
require "benchmark"

def pushing(ary,buf)
  puts "Pushing onto a ruby array"
  Benchmark.bm(7) do |x|
    x.report("first:")   { (1..1000000).each { |i| ary.push(i) } }
  end

  puts "Pushing onto a cbuffer"
  Benchmark.bm(7) do |x|
    x.report("first:")   { (1..1000000).each { |i| buf.put(i) } }
  end
end

def pulling(ary,buf)
  puts "Pull from a Array"
  Benchmark.bm(7) do |x|
    x.report("first:")   { (1..1000000).each { |i| ary.pop } }
  end

  puts "Pull from an cbuffer"
  Benchmark.bm(7) do |x|
    x.report("first:")   { (1..1000000).each { |i| buf.get } }
  end
end

def init
  ary = Array.new(1000000)
  buf = CBuffer.new(1000000)

  pushing(ary,buf)
  pulling(ary,buf)
end

init
