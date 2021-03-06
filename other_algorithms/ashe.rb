def digital_root(num)
  while num >= 10
    num = digital_root_step(num)
  end

  num
end

def digital_root_step(num)
  root = 0
  while num > 0
    root += (num % 10)

    num /= 10
  end

  root
end

#recursive solution

def digital_root_recur num
  return num if num < 10
  digital_root_recur((num % 10) + (num / 10))
end

def caesar_cipher(str, shift)
  letters = ("a".."z").to_a

  encoded_str = ""
  str.each_char do |char|
    if char == " "
      encoded_str << " "
      next
    end

    old_idx = letters.find_index(char)
    new_idx = (old_idx + shift) % letters.count

    encoded_str << letters[new_idx]
  end

  encoded_str
end

def longest_common_substring(str1, str2)
  longest_substring = ""

  start_idx = 0
  while start_idx < str1.length
    # don't consider substrings that would be too short to beat
    # current max.
    len = longest_substring.length + 1

    while (start_idx + len) <= str1.length
      end_idx = start_idx + len
      substring = str1[start_idx...end_idx]
      longest_substring = substring if str2.include?(substring)

      len += 1
    end

    start_idx += 1
  end

  longest_substring
end

def make_matrix(str1, str2)
  matrix = Array.new(str1.length + 1) { Array.new(str2.length + 1, 0) }

  str1.chars.each_with_index do |el1, idx1|
    str2.chars.each_with_index do |el2, idx2|
      if el1 == el2
        matrix[idx1 + 1][idx2 + 1] = matrix[idx1][idx2] + 1
      else
        matrix[idx1 + 1][idx2 + 1] = 0
      end
    end
  end

  matrix
end

def longest_common_substring(str1, str2)
  matrix = make_matrix(str1, str2)
  greatest_substring = ""
  matrix.each_with_index do |row, idx1|
    row.each_with_index do |length, idx2|
      if length > greatest_substring.length
        greatest_substring = str2[idx2 - length...idx2]
      end
    end
  end

  greatest_substring
end

def sum_rec(nums)
  return 0 if nums.empty?
  nums[0] + sum_rec(nums.drop(1))
end

def fibs(num)
  return [] if num == 0
  return [0] if num == 1

  fibs = [0, 1]
  while fibs.count < num
    fibs << fibs[-1] + fibs[-2]
  end

  fibs
end

def fibs(num)
  return [] if num == 0
  return [0] if num == 1
  return [0, 1] if num == 2

  prev_fibs = fibs(num - 1)
  prev_fibs << prev_fibs[-1]  + prev_fibs[-2]

  prev_fibs
end

def valid_ip?(str)
  return false unless str =~ /^\d+(\.\d+){3}$/
  nums = str.split(".").map(&:to_i)
  nums.all? {|num| num >= 0 && num <= 255}
end

def sum_from_file(filename)
  nums = File
    .readlines(filename)
    .select { |line| line[0] != "#" }
    .map(&:to_i)

  nums.inject(:+)
end

def shuffle(array)
  new_array = array.dup
  array.each_index do |index|
    # notice how each time it moves the number at `index` out of the
    # way so it may be sampled later.
    rand_index = index + rand(array.length - index)
    new_array[index], new_array[rand_index] =
      new_array[rand_index], new_array[index]
  end
  new_array
end

def folding_cipher(str)
  # Hash::[] creates a hash from a list of key-value pairs
  folded_alphabet = Hash[('a'..'z').zip(('a'..'z').to_a.reverse)]
  str.chars.map { |chr| folded_alphabet[chr] }.join
end

require 'set'

def uniq_subs(str)
  subs = Set.new

  str.length.times do |i|
    (i...str.length).each do |j|
      subs.add(str[i..j])
    end
  end

  subs
end

# Suppose your array is [5, 3, -7, 6], then:

# * The largest subsum is 8 with subarray [5, 3].
# * The largest subsum ending at the last element is 7 with subarray [5, 3, -7, 6].

# Say that you push 4 to the array to get [5, 3, -7, 6, 4].

# * The largest subsum ending at the last element is 11 with subarray [5, 3, -7, 6, 4].
# * The largest subsum overall is the max of the old largest subsum AND the new largest subsum.
# In other words, the new largest sum is 11 because [8, 11].max = 11.

def lcs(arr)
  lcs_helper(arr)[:best_sum]
end

def lcs_helper(arr)
  if arr.empty?
    return { best_sum: 0, best_suffix_sum: 0 }
  end

  # Note: using `arr.drop` would use O(n) extra space. But if you pass a `start_idx`
  # to `lcs_helper` and not create new arrays, you can achieve O(1) extra space.

  result = lcs_helper(arr.drop(1))
  old_best_sum, old_best_suffix_sum = result[:best_sum], result[:best_suffix_sum]
  new_best_suffix_sum = [old_best_suffix_sum + arr.first, arr.first].max
  new_best_sum = [old_best_sum, new_best_suffix_sum].max

  { best_sum: new_best_sum,
    best_suffix_sum: new_best_suffix_sum }
end

def lcs(arr)
    current_sum = 0
    max = arr.first || 0  # return 0 for empty array

    arr.each do |el|
        current_sum += el
        max = current_sum if max < current_sum
        current_sum = 0 if current_sum < 0
    end

    max
end

def silly_years(year)
  years = []

  until years.length == 10
    year += 1
    digits = year.to_s

    first_two, middle_two, last_two = [
      digits[0..1], digits[1..2], digits[2..-1]
    ].map { |pair| pair.to_i }

    years << year if (first_two + last_two) == middle_two

  end

  years
end

def silly_years(year)
  years = []

  year_arr = year.to_s.split("").map(&:to_i)

  # Keep going until we hit 10
  while years.length < 10

    # Calculate the digits using the principles above
    first_digit = year_arr[0]
    second_digit = year_arr[1]
    third_digit = -1 - first_digit + second_digit
    last_digit = 9 - first_digit

    # Set the year_arr
    year_arr = [first_digit, second_digit, third_digit, last_digit]

    # Make sure the year_arr is valid
    if year_arr.all? { |digit| digit.between?(0, 10) }
      current_silly_year = year_arr.map(&:to_s).join("").to_i

      # Just in case the current_silly_year is before our initial year
      years << current_silly_year if current_silly_year > year
    end

    # Time to move on to the next century
    year_arr[1] += 1

    # Carry if it's a new millenium
    if year_arr[1] >= 10
      year_arr[1] -= 10
      year_arr[0] += 1
    end
  end

  years
end

require 'set'

def pair_sum(arr, k)
  seen = Set.new
  pairs = Set.new

  arr.each do |num|
    target = k - num

    if seen.include?(target)
      # add in [min, max] order
      pairs.add(
        [[num, target].min, [num, target].max]
      )
    end

    # add `num` after checking; what if we put this before and there's
    # a single `0` is in the `arr`?
    seen.add(num)
  end

  pairs
end

pair_sum([1, 2, -1], 0)          # => #<Set: {[-1, 1]}>
pair_sum([1, 2, -1, -1], 0)      # => #<Set: {[-1, 1]}>
pair_sum([1, 2, -1, -1, -2], 0)  # => #<Set: {[-1, 1], [-2, 2]}>
pair_sum([1, 2, -1, -1, -2], 1)  # => #<Set: {[-1, 2]}>
pair_sum([1, 2, -1, -1, -2], -1) # => #<Set: {[-2, 1]}>

def matrix_region_sum(matrix, top_left_coords, bottom_right_coords)
  total_sum = 0

  (top_left_coords[0]..bottom_right_coords[0]).each do |row_idx|
    (top_left_coords[1]..bottom_right_coords[1]).each do |col_idx|
      total_sum += matrix[row_idx][col_idx]
    end
  end

  total_sum
end

def merge_sort(array)
  # already sorted
  return array if array.count < 2

  middle = array.count / 2
  left, right = array.take(middle), array.drop(middle)

  sorted_left, sorted_right = merge_sort(left), merge_sort(right)

  merge(sorted_left, sorted_right)
end

def merge(left, right)
  merged_array = []
  until left.empty? || right.empty?
    merged_array <<
      ((left.first < right.first) ? (left.shift) : (right.shift))
  end

  merged_array + left + right
end

def merge(left, right)
  merged_array = []
  i, j = 0, 0
  until i == left.length || j == right.length
    if left[i] > right[j]
      merged_array << right[j]
      j += 1
    else
      merged_array << left[i]
        i += 1
    end
  end
  merged_array + left.drop(i) + right.drop(j)
end #time complexity for merge is O(N)

def binary_search(array, target)
  return nil if array.count == 0

  midpoint = array.length / 2
  case target <=> array[midpoint]
  when -1
    binary_search(array.take(midpoint), target)
  when 0
    midpoint #return implied
  when 1
    subproblem_answer =
      binary_search(array.drop(midpoint + 1), target)
    subproblem_answer.nil? ? nil : (midpoint + 1) + subproblem_answer
  end
end

# Given a list of numbers in an array, replace all the numbers with the product of all other numbers. 
# Do this in O(n) time without using division.

def productify(arr)
  products = Array.new(arr.length, 1)

  lower_prod = 1
  0.upto(arr.size - 1) do |i|
    products[i] = products[i] * lower_prod
    lower_prod = lower_prod * arr[i]
  end

  upper_prod = 1
  (arr.size - 1).downto(0) do |i|
    products[i] = products[i] * upper_prod
    upper_prod = upper_prod * arr[i]
  end

  products
end 

def subsets(arr)
  return [[]] if arr.empty?

  val = arr[0]
  subs = subsets(arr.drop(1))
  new_subs = subs.map { |sub| sub + [val] }

  subs + new_subs
end

# subsets(['a', 'b', 'c'])
# subs_without_a => [[], ['c'], ['b'], ['c', 'b']]
# subs_with_a => [['a'], ['c', 'a'], ['b', 'a'], ['c', 'b', 'a']]
# all_subs = subs_without_a + subs_with_a

# We will finish with 2 n subsets, so at minimum our time complexity will be `O(2n)`.

def longest_palindrome(string)
  best_palindrome_start = 0
  best_palindrome_len = 0

  0.upto(string.length - 1).each do |start|
    # micro-optimization: don't look at substrings shorter than best
    # palindrome.
    len = best_palindrome_len + 1
    while start + len <= string.length
      if is_palindrome?(string, start, len)
        best_palindrome_start, best_palindrome_len = start, len
      end

      len += 1
    end
  end

  [best_palindrome_start, best_palindrome_start + best_palindrome_len - 1]
end

def is_palindrome?(string, start, len)
  len.times do |i|
    if string[start + i] != string[(start + len - 1) - i]
      return false
    end
  end

  true
end

# This will take O(N3) cubic time

def longest_palindrome(str)
    longest_length = 0
    longest_begin = 0

    str.length.times do |i|
        stretch = 0
        # expand out from char i, and see if there's an expanding palindrome
        # (for odd palindrome lengths)
        loop do
            break unless both_in_range?(i + stretch, i - stretch, str)

            if str[i - stretch] == str[i + stretch]
                this_pal_length = stretch * 2 + 1
                if this_pal_length > longest_length
                    longest_length = this_pal_length
                    longest_begin = i - stretch
                end
            else
              break
            end

            stretch += 1
        end

        # now check centering around the spaces between chars
        # (for even palindrome lengths)
        stretch = 0
        loop do
            break unless both_in_range?(i + stretch + 1, i - stretch, str)

            if str[i - stretch] == str[i + stretch + 1]
                this_pal_length = stretch * 2 + 2
                if this_pal_length > longest_length
                    longest_length = this_pal_length
                    longest_begin = i - stretch
                end
            else
              break
            end

            stretch += 1
        end
    end

    str.slice(longest_begin, longest_length)
end

def both_in_range?(i1, i2, str)
    [i1, i2].all? { |idx| idx.between?(0, str.length - 1) }
end

# O^2

# Ruby implementation of Manacher's linear-time algorithm for finding
# the longest palindromic substring in a string.
#
# Adapted from http://www.akalin.cx/longest-palindrome-linear-time.

require 'test/unit'

class Manacher
  class << self
    def find_longest(string)
      string_length = string.length
      l = []
      i = 0
      pal_len = 0

      while i < string_length do
        found_match = false

        if i > pal_len && string[i - pal_len - 1] == string[i]
          pal_len += 2
          i += 1

          next
        end

        l.push(pal_len)

        s = l.length - 2
        e = s - pal_len
        s.downto(e + 1) do |j|
          d = j - e - 1

          if l[j] == d
            pal_len = d
            found_match = true
            break
          end

          l.push([d, l[j]].min)
        end

        unless found_match
          pal_len = 1
          i += 1
        end
      end

      l.push(pal_len)

      l_len = l.length
      s = l_len - 2
      e = s - (2 * string_length + 1 - l_len)

      s.downto(e + 1) do |i|
        d = i - e - 1
        l.push([d, l[i]].min)
      end

      l
    end
  end
end

def intersection1(arr1, arr2)
  arr1.uniq.select { |el| arr2.include?(el) }
end

def intersection2(arr1, arr2)
  arr1, arr2, idx1, idx2 = arr1.sort, arr2.sort, 0, 0

  intersection = []
  while idx1 < arr1.length && idx2 < arr2.length
    case arr1[idx1] <=> arr2[idx2]
    when -1
      idx1 += 1
    when 0
      intersection << arr1[idx1]
      idx1 += 1
      idx2 += 1
    when 1
      idx2 += 1
    end
  end
  intersection
end #nlogn; sorting is NlogN and comparing is O(N)

def intersection3(arr1, arr2)
  intersection = []
  set_1 = arr1.to_set
  arr2.each do |el|
    intersection << el if set_1.include?(el)
  end

  intersection
end #O(N)

def common_subsets(arr1, arr2)
  subsets(intersection3(arr1, arr2))
end

def subsets(arr)
  return [[]] if arr.empty?

  val = arr[0]
  subs = subsets(arr.drop(1))
  new_subs = subs.map { |sub| sub + [val] }

  subs + new_subs
end

#ATT 6052949988A

def intersection1(arr1, arr2)
  arr1.uniq.select { |el| arr2.include?(el) }
end #ON^2

def intersection2(arr1, arr2)
  arr1, arr2, idx1, idx2 = arr1.sort, arr2.sort, 0, 0

  intersection = []
  while idx1 < arr1.length && idx2 < arr2.length
    case arr1[idx1] <=> arr2[idx2]
    when -1
      idx1 += 1
    when 0
      intersection << arr1[idx1]
      idx1 += 1
      idx2 += 1
    when 1
      idx2 += 1
    end
  end
  intersection
end #NlogN

def intersection3(arr1, arr2)
  intersection = []
  set_1 = arr1.to_set
  arr2.each do |el|
    intersection << el if set_1.include?(el)
  end

  intersection
end #ON

def common_subsets(arr1, arr2)
  subsets(intersection3(arr1, arr2))
end

def subsets(arr)
  return [[]] if arr.empty?

  val = arr[0]
  subs = subsets(arr.drop(1))
  new_subs = subs.map { |sub| sub + [val] }

  subs + new_subs
end

# can_win?([1, 0, 1], 0)
# => true

# can_win?([1, 2, 0], 0)
# => false

def can_win?(arr, pos = 0, seen = {})
  return false if !pos.between?(0, arr.length - 1) || seen[pos]
  return true if arr[pos].zero?

  seen[pos] = true

  can_win?(arr, pos + arr[pos], seen) ||
  can_win?(arr, pos - arr[pos], seen)
end

# A non-recursive solution.
def can_win(array, index)
  positions_to_try = [index]
  visited_positions = Array.new(array.length, false)
  visited_positions[index] = true

  until positions_to_try.empty?
    # We should probably use a queue for this.
    position = positions_to_try.shift
    value = array[position]

    if value == 0
      return true
    end

    [position + value, position - value].each do |pos|
      next if visited_positions[pos]
      next if (pos < 0 || array.length <= pos)

      positions_to_try << pos
      # This insures we don't add a position twice to our queue.
      visited_positions[pos] = true
    end
  end

  false
end

def sort1(arr)
  (1..(arr.length)).to_a
end

def sort2(arr, max_val)
  counts = Array.new(max_val + 1, 0)
  arr.each { |el| counts[el] += 1 }

  arr = []
  counts.each_index do |val|
    counts[val].times { arr << val }
  end
  arr
end

def sort3(strings, length)
  (length - 1).downto(0) do |i|
    buckets = Array.new(26) { [] }
    strings.each do |string|
      letter = string[i]
      buckets[letter.ord - "a".ord] << string
    end

    strings = []
    buckets.each do |bucket|
      bucket.each { |string| strings << string }
    end
  end

  strings
end

sort3([`cat`, `car`, `bat`])

# buckets after sorting by last letter
buckets = [[], ... , [`car`], ..., [`cat`, `bat`],  ...]

# strings after we join the buckets back together, now sorted by last letter
strings = [`car`, `cat`, `bat`]

# buckets after sorting by second to last letter - note that they retain their relative ordering by last letter in the buckets
buckets = [[`car`, `cat`, `bat`], ..., []]

# strings after we join the buckets back together, now sorted by last letter and second-to-last letter
strings = [`car`, `cat`, `bat`]

# lastly, buckets sorted by the first and most important letter
buckets = [[], ..., [`bat`], [`car`, `cat`] ...]

strings = [`bat`, `car`, `cat`]

def weighted_random_index(arr)
  total_sum = arr.inject(:+)
  value = rand(total_sum)

  cumulative_sum = 0
  arr.each_with_index do |el, i|
    cumulative_sum += el
    return i if value < cumulative_sum
  end
end

def move_zeros(array)
  current_index = 0
  num_zeros = 0

  while current_index < (array.length - num_zeros)
    current_value = array[current_index]

    if current_value != 0
      current_index += 1
      next
    end

    back = array.length - 1 - num_zeros
    array[current_index], array[back] =
      array[back], array[current_index]
    num_zeros += 1

    # we can't add one to current_index since `back` may have
    # contained a zero and we don't know it.
  end

  # Return the array
  array
end

def move_zeros2(arr)
  left, right = 0, arr.size - 1
  loop do
    left  += 1 until arr[left]  == 0 || left == right
    right -= 1 until arr[right] != 0 || left == right
    break if left == right
    arr[left], arr[right] = arr[right], arr[left]
  end
  arr
end

def look_and_say(array)
  return [] if array.empty?

  output = [[1, array[0]]]

  (1...array.length).each do |idx|
    el = array[idx]
    if el == output.last[1]
      output.last[0] += 1
    else
      output << [1, el]
    end
  end

  output
end

def which_missing_1(arr)
  arr.sort.each_with_index do |el, idx|
    return idx if el != idx
  end

  arr.length
end

def which_missing_2(arr)
  found = {}
  arr.each do |el|
    found[el] = true
  end

  0.upto(arr.length).each do |el|
    return el unless found[el]
  end
end

def which_missing_3(arr)
  total = (arr.length + 1) * arr.length / 2
  actual_sum = arr.inject(&:+)
  total - actual_sum
end

def k_closest_stars(sequence, k)
  # This we pass our MaxHeap a proc to calculate distance
  heap = BinaryMaxHeap.new do |el1, el2|
    distance1 = Math.sqrt(el1[0]**2 + el1[1]**2 + el1[2]**2)
    distance2 = Math.sqrt(el2[0]**2 + el2[1]**2 + el2[2]**2)
    distance1 <=> distance2
  end

  # Start off the heap with k items
  k.times do
    heap.push(sequence.pop)
  end

  # Until we reach the end, push on new items from our sequence and extract the max
  while sequence.length > 0
    heap.push(sequence.pop)
    heap.extract
  end

  # We can return an array of k closest stars
  k_closest = []

  until heap.empty?
    k_closest.push(heap.extract)
  end

  k_closest
end

class MaxStack
  def initialize
    @values = []
  end

  def push(value)
    if @values.empty?
      @values << [value, value]
    else
      new_max = [self.max, value].max
      @values << [value, new_max]
    end
  end

  def pop
    value, max = @values.pop

    value
  end

  def max
    @values.last[1]
  end
end

class StackQueue
  def initialize
    @in, @out = [], []
  end

  def enqueue(value)
    @in << value
  end

  def dequeue
    if @out.empty?
      @out << @in.pop until @in.empty?
    end

    @out.pop
  end
end

class MinMaxStack
  def initialize
    @entries = []
  end

  def length
    @entries.length
  end

  def push(value)
    if @entries.empty?
      @entries << { value: value, min: value, max: value }
    else
      @entries << {
        value: value,
        max: [@entries.last[:max], value].max,
        min: [@entries.last[:min], value].min
      }
    end
  end

  def pop
    (@entries.pop)[:value]
  end

  def max
    @entries.empty? ? nil : (@entries.last)[:max]
  end

  def min
    @entries.empty? ? nil : (@entries.last)[:min]
  end
end

class MinMaxStackQueue
  def initialize
    @in, @out = MinMaxStack.new, MinMaxStack.new
  end

  def enqueue(value)
    @in.push(value)
  end

  def dequeue
    if @out.length == 0
      @out.push(@in.pop) until @in.length == 0
    end

    @out.pop
  end

  def length
    @in.length + @out.length
  end

  def max
    maxes = []
    maxes << @in.max if @in.length > 0
    maxes << @out.max if @out.length > 0

    maxes.max
  end

  def min
    mins = []
    mins << @in.min if @in.length > 0
    mins << @out.min if @out.length > 0

    mins.min
  end
end

def windowed_max_range(array, window_size)
  max_range = nil

  q = MinMaxStackQueue.new
  array.each do |el|
    q.enqueue(el)
    if max_range.nil? || (q.max - q.min) > max_range
      max_range = (q.max - q.min)
    end

    if q.length == window_size
      q.dequeue
    end
  end

  max_range
end

def file_list(hash)
  files = []

  hash.each do |item, nested_item|
    if nested_item.is_a?(Hash)
      folder = item
      nested_files = file_list(nested_item)
      nested_files.each { |file| files << "#{folder}/#{file}" }
    else
      files << item
    end
  end

  files
end

def find_missing_number(array1, array2)
  array1.reduce(:+) - array2.reduce(:+)
end

# time: O(n), space: O(1)
def is_shuffle?(str1, str2, str3)
  return false unless str1.length + str2.length == str3.length

  idx1, idx2, idx3 = 0, 0, 0
  while idx3 < str3.length
    if str1[idx1] == str3[idx3]
      idx1 += 1
      idx3 += 1
    elsif str2[idx2] == str3[idx3]
      idx2 += 1
      idx3 += 1
    else
      return false
    end
  end

  true
end #NO REPEATS

# O(2**n): `str3.length == n + 1` requires twice the work of
# `str3.length == n`
def is_shuffle?(str1, str2, str3)
  return str1.empty? && str2.empty? if str3.empty?

  if str1[0] == str3[0]
    return true if is_shuffle?(str1[1..-1], str2, str3[1..-1])
  end

  if str2[0] == str3[0]
    return true if is_shuffle?(str1, str2[1..-1], str3[1..-1])
  end

  false
end #with repeats

def is_shuffle?(str1, str2, str3)
  candidates = [[0, 0]]

  until candidates.empty?
    str1_used_len, str2_used_len = *(candidates.shift)
    str3_used_len = str1_used_len + str2_used_len

    if str3_used_len == str3.length
      return true
    end

    if str1[str1_used_len] == str3[str3_used_len]
      candidates << [str1_used_len + 1, str2_used_len]
    end
    if str2[str2_used_len] == str3[str3_used_len]
      candidates << [str1_used_len, str2_used_len + 1]
    end
  end

  false
end

def is_shuffle?(str1, str2, str3)
  seen_candidates = Hash.new(false)
  candidates = [[0, 0]]

  until candidates.empty?
    str1_used_len, str2_used_len = *(candidates.shift)
    str3_used_len = str1_used_len + str2_used_len

    if str3_used_len == str3.length
      return true
    end

    if str1[str1_used_len] == str3[str3_used_len]
      new_candidate = [str1_used_len + 1, str2_used_len]
      if !seen_candidates[new_candidate]
        candidates << new_candidate
        seen_candidates[new_candidate] = true
      end
    end
    if str2[str2_used_len] == str3[str3_used_len]
      new_candidate = [str1_used_len, str2_used_len + 1]
      if !seen_candidates[new_candidate]
        candidates << new_candidate
        seen_candidates[new_candidate] = true
      end
    end
  end

  false
end

def binary(num)
  result = []

  until num == 0
    result.unshift(num % 2)
    num /= 2
  end

  result.empty? ? "0" : result.join
end

def recursive_fac(num)
  return num if num == 1
  tail_rec(num - 1) * num
end

def tail_recursive_fac(num, prod = 1)
  return prod if num == 1
  return tail_recursive_fac(num - 1, prod * num)
end

def iterative_fac(num)
  product = 1
  2.upto(num) { |i| product *= i }

  product
end

# O(n**2)
def max_unique_psub(str)
  psub = str[str.length - 1]

  (str.length - 2).downto(0) do |i|
    next if str[i] < psub[0]
    # CAREFUL: this takes O(n) in the inner loop to copy the contents of
    # psub to create the new string.
    psub = str[i] + psub
  end

  psub
end

# Slight rewriting that is O(n)
def max_unique_psub(str)
  psub_arr = [str[str.length - 1]]

  (str.length - 2).downto(0) do |i|
    next if str[i] < psub_arr.last
    # this is amortized O(1) time.
    psub_arr << str[i]
  end

  psub = psub_arr.reverse.join("")
  psub
end

# O(n!)
def permutations(arr)
  return [[]] if arr.empty?

  perms = []
  arr.length.times do |i|
    # Choose an element to be first
    el = arr[i]
    rest = arr.take(i) + arr.drop(i + 1)

    # Find permutations of the rest, and tack the first `el` at front.
    new_perms = permutations(rest).map { |perm| perm.unshift(el) }
    perms.concat(new_perms)
  end

  perms
end

def cyclic1?(first_link)
  set = Set.new

  current_link = first_link
  until current_link.nil?
    # if list is cyclic, must loop back on itself eventually
    return true if set.include?(current_link)
    set << current_link

    current_link = current_link.next
  end

  false
end

def cyclic2?(first_link)
  slow_runner = first_link
  fast_runner = first_link

  while true
    2.times do
      fast_runner = fast_runner.next
      return false if fast_runner.nil?
      return true if fast_runner == slow_runner
    end

    slow_runner = slow_runner.next
  end
end

def converge?(a, b)
  difference = find_difference(a, b)

  a_runner = a
  b_runner = b

  if difference > 0
    difference.times do
      b_runner = b_runner.next
    end
  else
    (-difference).times do
      a_runner = a_runner.next
    end
  end

  until a_runner.nil?
    return true if a_runner == b_runner
    a_runner = a_runner.next
    b_runner = b_runner.next
  end

  false
end

def find_difference(a, b)
  difference = 0

  a_runner = a
  b_runner = b

  until a_runner.nil? && b_runner.nil?
    if a_runner.nil?
      difference += 1
      b_runner = b_runner.next
    elsif b_runner.nil?
      difference -= 1
      a_runner = a_runner.next
    else
      a_runner = a_runner.next
      b_runner = b_runner.next
    end
  end

  difference
end

# O(log(n)) if BST is balanced
def next_largest(node)
  if node.right
    # find smallest node to the right
    return left_most_node(node.right)
  end

  # no nodes to the right; climb up
  until true
    parent_node = node.parent
    if parent_node.nil?
      # at the top of the tree, and nothing bigger to the right.
      return nil
    elsif parent_node.left == node
      # parent is bigger than us
      return parent_node
    else
      # parent is smaller, keep climbing.
      node = parent_node
    end
  end
end

def left_most_node(node)
  # keep going down and to the left
  node = node.left until node.left.nil?

  node
end

        5
      /   \
    2       7
  /   \   /   \
1      3 6     8

left_most_node(node_5)
=> node_6

        5
      /   \
    2       7
  /   \   /   \
1      3 6     8

left_most_node(node_3)
=> node_5

# O(n): must check every node (stops at first detected violation).
def is_bst?(node, min = nil, max = nil)
  return true if node.nil?

  # does this node violate constraints?
  if (min && (min > node.value)) || (max && (max < node.value))
    return false
  end

  # this node follows constraints; do its children, too?
  is_bst?(node.left, min, node.value) && is_bst?(node.right, node.value, max)
end

def rand7
  while true
    # construct a random number (0...5**2)
    # (0, 5, 10, 15, 20) + (0, 1, 2, 3, 4)
    num = 5 * rand5 + rand5
    return (num % 7) if num < 21

    # we reject 21, 22, 23, 24; we'll choose another number in that
    # case.
  end
end

def rand7
  result = 0
  result += (rand5 < 3 ? 0 : 1)
  result += (rand5 < 3 ? 0 : 2)
  result += (rand5 < 3 ? 0 : 4)
  result
end

def sqroot(num, candidates = nil)  
  return num if num == 1    
  candidates ||= (0..num / 2).to_a
  middle = candidates.length / 2
  case num <=> (candidates[middle] * candidates[middle])
  when -1
      sqroot(num, candidates.take(middle))
  when 0
      middle
  when 1
      sub_answer = sqroot(num, candidates.drop(middle + 1))
      (sub_answer.nil?) ? nil : (middle + 1) + sub_answer
  end
end

def print_spiral(a)
  a = a.deep_dup(1)
  result = []

  while true
    break if a.length == 0 || a[0].length == 0

    # remove the first row
    result.concat(a.shift)
    break if a.length == 0 || a[0].length == 0

    # remove the right side
    a.each { |row| result << row.pop }
    break if a.length == 0 || a[0].length == 0

    # remove the bottom row
    result.concat(a.pop.reverse)
    break if a.length == 0 || a[0].length == 0

    # remove the left side
    a.reverse.each { |row| result << row.shift }
  end

  result
end

 def duplicates(arr)
   values = Set.new
   copies = Set.new

   arr.each do |value|
    if values.include?(value)
     copies << value
    else
     values << value
    end
   end

   return copies
end

def key_chance(hash)
  total = hash.values.inject(&:+)
  selection = rand(total)

  sum = 0
  hash.each do |k, v|
    sum += v
    if selection < sum
      return k
    end
  end
end

# For the hash {:a => 1, :b => 2, :c => 3}, the chance of returning :c is 1/2, :b is 1/3, and :a is 1/6.

# Running time is linear in the number of edges.

lines = File.readlines(FILE_NAME)

matrix = {}
lines.each do |line|
  v1, v2 = line.split(" ")
  matrix[v1] ||= []
  matrix[v1] << v2
  matrix[v2] ||= []
  matrix[v2] << v1
end

components = []
until matrix.empty?
  component = []

  first_key = matrix.keys.first
  queue = [first_key]
  until queue.empty?
    key = queue.shift
    next unless matrix.has_key?(key)
    neighbors = matrix.delete(key)

    component << key
    queue.concat(neighbors)
  end

  components << component
end


def streaming_sample(stream)
  sample = stream
  num_els = 1 #needs to set to the first stream because otherwise first one never gets picked

  while true
    next_value = stream.next_value
    break if next_value.nil?

    # keep sample with probability 1 / (num_els + 1)
    keep_prob = 1.fdiv(num_els + 1)
    sample = next_value if rand() < keep_prob

    num_els += 1
  end

  sample
end