function bar(cr, width, height, value)
    local w = width / 10
    local h = 12

    for x = 0, 10
    do
      if value <= x * 10
      then
        cr:set_source_rgb(0.176, 0.176, 0.176)
      elseif x < 2
      then
        cr:set_source_rgb(0.533, 0.753, 0.816)
      elseif x < 4
      then
        cr:set_source_rgb(0.639, 0.745, 0.549)
      elseif x < 6
      then
        cr:set_source_rgb(0.922, 0.796, 0.545)
      elseif x < 8
      then
        cr:set_source_rgb(0.816, 0.529, 0.439)
      else
        cr:set_source_rgb(0.749, 0.38, 0.416)
      end

      cr:rectangle(w * x, height / 2 - h / 2, w, h)
      cr:fill()
    end
end
