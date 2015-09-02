#Problem 1: You have array of integers. Write a recursive solution to find
#the sum of the integers.
require 'byebug'
def sum_recur(array)
  return 0 if array.length == 0
  array.last + sum_recur(array[0..-2])

end


#Problem 2: You have array of integers. Write a recursive solution to
#determine whether or not the array contains a specific value.

def includes?(array, target)
  return false if array.length == 0
   array.first == target ? true : includes?(array[1..-1],target)
end


#Problem 3: You have an unsorted array of integers. Write a recursive
#solution to count the number of occurrences of a specific value.

def num_occur(array, target)
  return 0 if array.length == 0
  num = num_occur(array[1..-1],target)
  if array.first == target
    return num + 1
  else
    return num
  end


end


#Problem 4: You have array of integers. Write a recursive solution to
#determine whether or not two adjacent elements of the array add to 12.

def add_to_twelve?(array)
  return false if array.length <= 1
  return true if array[1] + array.first == 12
  add_to_twelve?(array[1..-1])
end


#Problem 5: You have array of integers. Write a recursive solution to
#determine if the array is sorted.

def sorted?(array)
  return true if array.length <= 1
  return false if array[1] < array[0]
  sorted?(array.drop(1))
end


#Problem 6: Write the code to give the value of a number after it is
#reversed. Must use recursion. (Don't use any #reverse methods!)
#reverse(12) - remainder is reverse(2) is 2
#2.to_s + 1.to_s
def reverse(number)
  debugger
  return number if number.to_s.length == 1
  reversed_remainder = reverse(number.to_s[1..-1])
  (reversed_remainder.to_s + number.to_s[0]).to_i
end

p reverse(3025000)
