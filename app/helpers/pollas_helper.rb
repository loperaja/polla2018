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
  
  def partial_name
    (["octavos", "cuartos", "semis"].include? @polla.wizard_step) ? "rondas" : @polla.wizard_step
  end

  def show_fields?(f)
    ((@round.map(&:id).include? f.resultable_id) && f.resultable_type == @round.first.class.to_s)
  end

  def progress_bar(p)
    content_tag :div, class: 'progress' do
      content_tag(:div, "#{p.progress}%", class: 'progress-bar', role: 'progressbar', aria: {valuenow: p.progress, valuemin: "0", valuemax: "100"}, style: "width: #{p.progress}%; background-color: #50292a;")
    end
  end

end
