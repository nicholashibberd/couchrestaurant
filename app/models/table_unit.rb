class TableUnit < Unit
	property :columns, :default => []
  property :rows, :default => []

  def add_row
    rows << {}
  end
  
  def delete_row(params)
    value = Integer(params.index("Delete"))
    self.rows.delete_at(value)
  end

  def add_column(params)
    columns << params
  end
  
  def delete_column(params)
    value = Integer(params.index("Delete"))
    self.columns.delete_at(value)
  end
  
  def find_entry_by_column(row_number, column)
    row = self.rows[row_number]
    row[column]
  end

end