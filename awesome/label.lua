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
    self.color = args.color or label_color
    self.widget = wibox.widget.textbox()
    self.widget.set_align("right")
    self:update()
    return self
end

function label:update()
    self.widget.markup = ' | <span foreground=\"' .. self.color .. '\"> '.. self.label ..' </span>'
end

return setmetatable(label, {
    __call = label.new,
})


