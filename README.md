# CBuffer

## Overview

A circular buffer, cyclic buffer or ring buffer is a data structure that uses 
a single, fixed-size buffer as if it were connected end-to-end. This structure 
lends itself easily to buffering data streams. This library impliments such a 
buffer.

## Installation

    gem install cbuffer

** Usage

    require 'cbuffer'

    a = CBuffer.new 5 => <CBuffer @size=5> 
    a.put 1 => false 
    a.put 2 => false 
    a.put "Duncan" => false 
    a.put 999 => false 
    a.get => 1 
    a.get => 2 
    a.get => "Duncan" 
    a.put "xxx" => false 
    a.get => 999

## Todo

* threading support 
* fetch items by index
* view onto items

## Contributing

* Fork the project
* Send a pull request
* Don't touch the .gemspec, I'll do that when I release a new version
