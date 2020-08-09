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