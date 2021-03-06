module Steppable


  def get_moves(board, current_pos, vectors, color)
    positions = []

    vectors.each do |vector|
      curr_pos = current_pos

      curr_pos = curr_pos[0] + vector[0], curr_pos[1] + vector[1]
      move_helper(board, curr_pos, positions, color)
    end

    positions
  end

  private

  def move_helper(board, curr_pos, positions, color)
    if inside_boundaries?(curr_pos) && invalid_pos?(board, curr_pos)
      positions << curr_pos if check_color(curr_pos, color)
    end

    unless !inside_boundaries?(curr_pos) || invalid_pos?(board, curr_pos)
      positions << curr_pos unless positions.include?(curr_pos)
    end
  end

  def check_color(pos, color)
    board[pos].color != color
  end

  def invalid_pos?(board, pos)
    !board[pos].empty?
  end

  def inside_boundaries?(pos)
    pos.all? { |el| el.between?(0, 7) }
  end

end
