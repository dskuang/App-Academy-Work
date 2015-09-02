require 'byebug'

class Array

  def uniq
    arr = []
    self.each do |val|
      arr << val unless arr.include?(val)
    end

    arr
  end

  def two_sum
    arr = []

    self.each_with_index do |val, idx1|
      ((idx1 + 1)...self.length).each do |idx2|
        if val == -self[idx2]
          arr << [idx1, idx2]
        end
      end
    end

    arr
  end

  def median
    return nil if empty?
    length.even? ? (self[length/2] + self[length/2 - 1])/2 : self[length/2]

  end

  def my_transpose
    transpose_matrix = []
	  self.count.times { transpose_matrix << [] }

    self.each_with_index do |row, row_index|
		# then iterate over each element of the row in the existing matrix
		  row.each_with_index do |row_element, column_index|
			# add the element of each row, to the new column arrays in the transpose matrix
			   transpose_matrix[column_index] << row_element
		  end
	  end


    transpose_matrix
  end

  def stock_picker
  	highest_profit = 0
  	buying_day = nil
  	selling_day = nil

  	self.each_with_index do |buying_pr, buying_d|
  		self.each_with_index do |selling_pr, selling_d|
  			if buying_d < selling_d
  				profit = selling_pr - buying_pr
  				if profit > highest_profit
  					highest_profit = profit
  					buying_day = buying_d
  					selling_day = selling_d
  				end
  			end
  		end
  	end
  	[buying_day, selling_day]
  end


end

#p [1,2,3].my_transpose
#p [2,3,3,2].two_sum
