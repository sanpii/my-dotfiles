function find(database, plugin_src)
    for _, finding in ipairs(database.findings)
    do
        if finding.plugin_url == plugin_src
        then
            return true
        end
    end

    return false
end

function check(database, plugins)
    local suspicious = {}

    for n, plugin in ipairs(plugins)
    do
        if find(database, plugin.spec.src)
        then
            table.insert(suspicious, plugin.spec.name)
        end
    end

    if table_is_empty(suspicious)
    then
        vim.print("No suspicious plugin found")
        return
    end

    vim.print("Suspicious plugins:")
    for _, name in ipairs(suspicious)
    do
        vim.print(("- %s"):format(name))
    end
end

vim.pack.suspicious = function()
    local plugins = vim.pack.get()

    if #plugins == 0
    then
        vim.notify('No plugin installed', 'WARN')
        return
    end

    vim.net.request(
        'https://github.com/phanen/nvim-suspicious-plugin-scanner/raw/refs/heads/master/report.json',
        {},
        function (err, res)
            if err then
                vim.notify(error, 'ERROR')
                return
            end

            local database = vim.json.decode(res.body)

            check(database, plugins)
        end
    )
end
