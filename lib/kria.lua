local Kria = {}

Kria.cv_event_handlers = {}
Kria.cv_values = {}

local function crow_event_handler(event, value)
  if event.name == "cv" then
    channel = event.arg + 1
    note = util.round(value / (1 / 12))
    Kria.cv_event_handlers[channel](note)
    Kria.cv_values[channel] = note
  end
end

function Kria.init()
  print("init kria")
  crow.ii.kria.event = crow_event_handler
end

function Kria.get_cv(channel)
  crow.ii.kria.get("cv", channel - 1)
end

return Kria