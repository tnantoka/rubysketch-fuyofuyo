require 'rubygems'
require 'bundler/setup'
Bundler.require

R = 100 # RADIUS is used by rubysketch
FREQUENCY = 10
SIZE = 300

Point = Struct.new(:x, :y)

size SIZE, SIZE
center = Point.new(width / 2, height / 2)

amplitude = 0
amplitude_dir = 1

draw do
  background('#ffffff')

  points = 0.step(to: 361, by: 0.05).map do |degrees|
    radians = degrees * Math::PI / 180
    noise = Math.sin(radians * FREQUENCY) * amplitude
    Point.new(
      center.x + Math.cos(radians) * (R + noise),
      center.y + Math.sin(radians) * (R + noise)
    )
  end

  points.each_slice(2) do |p1, p2|
    point p1.x, p1.y
  end

  amplitude += amplitude_dir
  amplitude_dir *= -1 unless (-14..14).include?(amplitude)
end
