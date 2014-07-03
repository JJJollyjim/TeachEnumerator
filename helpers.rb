helpers do
  def tick_or_cross(bool)
    if bool then
      '✓'
    else
      '✗'
    end
  end
  
  def red_or_green(bool)
    if bool then
      'color-green'
    else
      'color-red'
    end
  end
end
