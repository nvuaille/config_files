local awful = require("awful")
local watch = require("awful.widget.watch")
local wibox = require("wibox")

local ramgraph_widget = {}

local function worker(args)

    local args = args or {}
    local color1 = args.color1 or '#74aeab'
    local color2 = args.color2 or '#ffaa00'
    local bg_color = args.bg_color or '#26403f'


    --- Main ram widget shown on wibar
    ramgraph_widget = wibox.widget {
        border_width = 0,
        colors = {
          color1, bg_color
        },
        display_labels = false,
        forced_width = 25,
        widget = wibox.widget.piechart
    }

    --- Widget which is shown when user clicks on the ram widget
    local w = wibox {
        height = 200,
        width = 400,
        ontop = true,
        expand = true,
        bg = '#1e252c',
        max_widget_size = 500
    }

    w:setup {
        border_width = 0,
        colors = {
            '#5ea19d', -- used
            '#85915e', -- free
            '#4b817e', -- buff
        },
        display_labels = false,
        forced_width = 25,
        id = 'pie',
        widget = wibox.widget.piechart
    }

    local total, used, free, shared, buff_cache, available, total_swap, used_swap, free_swap

    local function getPercentage(value)
        return math.floor(value / (total+total_swap) * 100 + 0.5) .. '%'
    end

    watch('bash -c "LANGUAGE=en_US.UTF-8 free | grep -z Mem.*Swap.*"', 1,
        function(widget, stdout, stderr, exitreason, exitcode)
            total, used, free, shared, buff_cache, available, total_swap, used_swap, free_swap =
                stdout:match('(%d+)%s*(%d+)%s*(%d+)%s*(%d+)%s*(%d+)%s*(%d+)%s*Swap:%s*(%d+)%s*(%d+)%s*(%d+)')

            widget.data = { used, total-used }-- widget.data = { used, total-used }

            if w.visible then
                w.pie.data_list = {
                    {'used ' .. getPercentage(used + used_swap), used + used_swap},
                    {'free ' .. getPercentage(free + free_swap), free + free_swap},
                    {'buff_cache ' .. getPercentage(buff_cache), buff_cache}
                }
            end
            if ( used / total) > 0.7  then
              widget.colors = {
                color2, bg_color
              }
            else
              widget.colors = {
                color1, bg_color
              }
            end

            collectgarbage()
        end,
        ramgraph_widget
    )

    ramgraph_widget:buttons(
        awful.util.table.join(
            awful.button({}, 1, function()
                awful.placement.top_right(w, { margins = {top = 25, right = 10}, parent = awful.screen.focused() })
                w.pie.data_list = {
                    {'used ' .. getPercentage(used + used_swap), used + used_swap},
                    {'free ' .. getPercentage(free + free_swap), free + free_swap},
                    {'buff_cache ' .. getPercentage(buff_cache), buff_cache}
                }
                w.pie.display_labels = true
                w.visible = not w.visible
            end)
        )
    )


    return ramgraph_widget
end

return setmetatable(ramgraph_widget, { __call = function(_, ...)
    return worker(...)
end })
