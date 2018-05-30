module ApplicationHelper

  def match_row_div(size, index)
    per_group = Result::MATCHES_PER_GROUP
    row = false
    numcols = 12/size
    if index % per_group == 0
      row = (((index/per_group) % numcols) == 0)
    end
    return row
  end

  def row_contents(size, &block)
    content_tag :div, class: "col-lg-#{size}" do
      block.call
    end
  end

end
