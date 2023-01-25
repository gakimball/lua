-- (Unfinished) MobX-style observable

local trackerid = 0
local trackedobservables = {}

Observable = {}
Observable.__index = Observable

function Observable:new(defaultValue)
  return setmetatable({
    _value = defaultValue,
    _listeners = {},
  }, Observable)
end

function Observable:get()
  table.insert(trackedobservables, self)

  return self._value
end

function Observable:set(value)
  self._value = value

  for _, listener in pairs(self._listeners) do
    listener(value)
  end
end

function Observable:observe(listener)
  local id = tostring(trackerid)

  trackerid = trackerid + 1

  self._listeners[id] = listener
end

local autorun = function(tracker)
  tracker()



  trackedobservables = {}
end
