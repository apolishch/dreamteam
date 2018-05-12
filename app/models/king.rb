class King < ChessPiece
  belongs_to :game

  def has_moved?
    super
  end

  def is_obstructed?(x, y)
    super
  end

  def opponent_pieces
    my_color = self.color
    opponent_pieces = self.game.chess_pieces.where(color: !my_color)
    return opponent_pieces
  end

  def can_castle?(x, y)
      return false if !self.is_obstructed?(x, y)
      return false if !self.has_moved?
      return false if !self._has_rook_moved?(x, y)
      return false if !self.castle_will_cause_check?(x, y)
      
      true
  end

  def castle_will_cause_check?(x, y)
    (self.x_position..x).each do |x|
      return false if !pieces_causing_check(x, self.y_position).empty?
    end

    true
  end

  def pieces_causing_check(x = self.x_position, y = self.y_position)
    pieces_causing_check = []
    self.opponent_pieces.each do |piece|
      if piece.valid_move?(x, y, self.color)
        pieces_causing_check << piece
      end
    end
    return pieces_causing_check
  end

  def in_check?
     if (self.pieces_causing_check).empty?
        false
     else
        true
     end
  end

  # converts coordinates passed in to Rook
  def _has_rook_moved?(x, y)
      rook = ChessPiece.where(:game_id => self.game_id, :x_position => x, :y_position => y ).first
      return false if rook.nil?
      return false if rook.type != "Rook"

      self.has_rook_moved?(rook)
  end

  def has_rook_moved?(rook)
      rook.has_moved?
  end

  def x_move_distance(new_x_position) # Finds the distance moved in the x axis
    x_move_distance = (self.x_position - new_x_position).abs # .abs stops it from being negative
  end

  def y_move_distance(new_y_position) # Finds the distance moved in the y axis
    y_move_distance = (self.y_position - new_y_position).abs # .abs stops it from being negative
  end

  def valid_move?(new_x_position, new_y_position, color=nil)
    invalid = !super
    if invalid
      return false
    else
      x_distance = x_move_distance(new_x_position)
      y_distance = y_move_distance(new_y_position)
      return valid_x_y_move?(x_distance, y_distance)
    end
  end

  def valid_x_y_move?(x_distance, y_distance)
    invalid = !(x_distance == 0 && y_distance == 1) &&    # Vertical move distance is 1
      !(x_distance == 1 && y_distance == 0) &&  # Horizontal move distance is 1
      !(x_distance == 1 && y_distance == 1)     # Diagonal move distance is 1
    invalid ? false : true
  end

  def checkmate?
    return false unless in_check?
    return false if self.can_escape_from_check?
    return true if pieces_causing_check.length > 1
    return false if pieces_causing_check.first.can_threatening_piece_be_captured?
    return false if pieces_causing_check.first.can_threat_be_blocked?
    true
  end

  def can_escape_from_check?
    original_x = x_position
    original_y = y_position
    can_escape = false
    ((x_position - 1)..(x_position + 1)).each do |x|
      ((y_position - 1)..(y_position + 1)).each do |y|
        update_attributes(x_position: x, y_position: y) if valid_move?(x, y)
        can_escape = true unless in_check?
        update_attributes(x_position: original_x, y_position: original_y)
      end
    end
    can_escape
  end
end
