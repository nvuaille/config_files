-- Volume Control
local wibox = require("wibox")

------------------------------------------
-- Volume control interface
------------------------------------------

local label = {}

function label:new(args)
    return setmetatable({}, {__index = self}):init(args)
end

function label:init(args)
--    self.device = args.device or nil
--    self.cardid  = args.cardid or nil
    self.label = args.label or ''
    self.widget = wibox.widget.textbox()
    self.widget.set_align("right")
    self:update()
    return self
end

function label:update()
    local labelColor = "#0fff00"
    self.widget.markup = ' | <span foreground=\"' .. labelColor .. '\"> '.. self.label ..' </span>'
end

return setmetatable(label, {
    __call = label.new,
})


