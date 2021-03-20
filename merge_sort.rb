# frozen_string_literal: false

def merge_arrays(array1, array2)
  output = []

  while array1.length.positive? && array2.length.positive?
    array_to_move = array1.first < array2.first ? array1 : array2
    move_to_output(array_to_move, output)
  end
  array1.each { |num| output.push(num) }
  array2.each { |num| output.push(num) }
  output
end

def move_to_output(array, output)
  output.push(array.first)
  array.shift
  output
end

def merge_sort(array)
  # Base case
  if array.length == 1
    array
  else
    # Split the array in two
    left_array = array[0..(array.length / 2) - 1]
    right_array = array[array.length / 2..array.length]

    # Sort the two halves
    left_array = merge_sort(left_array)
    right_array = merge_sort(right_array)

    # Merge the sorted arrays
    merge_arrays(left_array, right_array)
  end
end

def time_diff_milli(start, finish)
  (finish - start) * 1000
end

puts "A random array of integers will be created and then sorted. Please specify how many elements you'd"\
' like in that array:'

array = []
begin
  gets.chomp.to_i.times { array.push(rand(1..1_000_000)) }

  puts 'This is the array before merge sort...'
  puts "\n"

  p array

  puts 'This is the array after merge sort...'
  puts "\n"

  t1 = Time.now

  sorted_array = merge_sort(array)

  t2 = Time.now

  p sorted_array
  puts "The merge sort operation took #{time_diff_milli(t1, t2).round(4)} milliseconds"
rescue SystemStackError
  puts 'Sorry, you ran out of space in the stack! If you entered anything but an integer... tutt tutt!!'
  puts 'If you entered a large integer, then try a smaller value.'
rescue NoMethodError
  puts 'Are you sure you entered a number?'
end
