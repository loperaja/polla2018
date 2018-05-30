module PollasHelper

  def position_title(name)
    pos = case name.last.to_i
    when 1
      "Primer"
    when 2
      "Segundo"
    when 3
     "Tercer"
    when 4
      "Cuarto"
    else
      nil
    end

    return "#{pos} lugar (#{name})"
  end

  def position_row_div(size, index)
    per_group = 4
    row = false
    numcols = 12/size
    if index % per_group == 0
      row = (((index/per_group) % numcols) == 0)
    end
    return row
  end

end
