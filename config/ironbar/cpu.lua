return function(cr, width, height)
    local cpu = ironbar:var_get("sysinfo.cpu_percent.mean")
    bar(cr, width, height, cpu)
end
