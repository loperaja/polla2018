module ApplicationHelper

  def row_div(size, index)
    row = false
    if index == 0
      row = true
    elsif(index % (12/size) == 0)
      row = true
    end
    return row
  end

  def row_contents(size, &block)
    content_tag :div, class: "col-lg-#{size}" do
      block.call
    end
  end

end
