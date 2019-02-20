#!/usr/bin/env ruby

require_relative 'cube'
require_relative 'data'

def substitute_chars(input, unused_chars, subst_map)
  word_count = {}
  input.each_char.with_index(0) do |char, idx|
    next if idx == input.size - 1
    word = input[idx .. idx + 1]
    word_count[word] = 0 if word_count[word].nil?
    word_count[word] += 1
  end
  compressed_candidate = input
  compressed = input
  subst = nil
  word_count.each do |word, count|
    next if count < 4 || !compressed.include?(word) || unused_chars.empty?
    subst = unused_chars.shift if subst.nil?
    compressed_candidate = input.gsub(word, subst)
    if compressed_candidate.size <= compressed.size
      compressed = compressed_candidate
      subst_map[subst] = word
    end
  end
  return compressed
end

def compress(input)
  unused_chars = []
  subst_characters = (' ' .. '~').to_a.reverse
  subst_characters.each do |char|
    # substitution characters must be safe from RegExp point of view
    next if ['|', '\\', '[', ']', '?', '+', '*', '(', ')',
             '.', '^', '\'', '$', '{', '}'].include?(char)
    unused_chars.push(char) if !input.include?(char)
  end
  subst_map = {}
  compressed = input
  prev_compressed = ''
  while (unused_chars.size > 0) do
    prev_compressed = compressed
    compressed = substitute_chars(compressed, unused_chars, subst_map)
    break if prev_compressed == compressed
  end

  subst = ''
  subst_map.keys.reverse.each do |char|
    subst = subst + "#{char}#{subst_map[char]}"
  end

  puts "Compressed : '#{compressed}'"
  puts "Subst. map : '#{subst}'"
  puts "Size       : #{compressed.size + subst.size} / #{input.size}"
end

compress(CUBE + DATA)
