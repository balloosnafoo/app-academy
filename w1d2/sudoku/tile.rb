class Tile

  attr_accessor :group, :row, :column, :value, :given

  def initialize(row, column, group)
    @group = group
    @row = row
    @column = column
    @value = nil
    @given = false
  end

  def in_row?(row)
    @row == row
  end

  def in_column?(column)
    @column == column
  end

  def in_group?(group)
    @group == group
  end

  def to_s
    @value || " "
  end

end
