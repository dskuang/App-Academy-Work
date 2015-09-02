module Movement
  def get_sliding_moves (vector, pos, board)
    x, y = pos[0], pos[1]
    possible_pos = [[x + vector, y + 1],[x + vector, y - 1]]
    possible_pos.select! do |pos|
      (pos.all?{ |val| within_boundaries?(val) }) && pos_empty?(pos)
    end
    possible_pos
  end


  def within_boundaries?(num)
    num.between?(0,7)
  end


  def pos_empty?(pos)
    board[pos].empty?
  end

  def get_jumping_moves (vector, pos, board, color)
    x, y = pos[0], pos[1]
    possible_pos = [[x + vector, y + 2],[x + vector, y - 2]]

    possible_pos.select! do |position|
      inter = get_intermediate_pieces(pos, position)
      position.all?{ |val| within_boundaries?(val)} && pos_empty?(position) &&\
      (board[inter].color !=  board[pos].color && !board[inter].empty?)

    end
    possible_pos

  end

  def get_intermediate_pieces(pos, possible_pos)
     [(possible_pos.first + pos.first)/2, (possible_pos.last + pos.last)/2]
  end


end
