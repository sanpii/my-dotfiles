return function(cr, width, height)
    local memory = ironbar:var_get("sysinfo.memory_percent")
    bar(cr, width, height, memory)
end
