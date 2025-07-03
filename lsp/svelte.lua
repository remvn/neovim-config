return {
    settings = {
        svelte = {
            plugin = {
                css = {
                    globals = "./src/svelte-var.css"
                }
            }
        }
    },
    before_init = function(_, config)
        local files = vim.fn.glob("**/svelte-var.css", nil, true)
        if next(files) == nil then
            return
        end
        local str = table.concat(files, ",")
        config.settings.svelte.plugin.css.globals = str
    end
}
