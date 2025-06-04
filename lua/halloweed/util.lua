local util = {}

util.bg = "#000000"
util.fg = "#ffffff"

local function hexToRgb(hex_str)
  local hex = "[abcdef0-9][abcdef0-9]"
  local pat = "^#(" .. hex .. ")(" .. hex .. ")(" .. hex .. ")$"
  hex_str = string.lower(hex_str)

  assert(string.find(hex_str, pat) ~= nil, "hex_to_rgb: invalid hex_str: " .. tostring(hex_str))

  local r, g, b = string.match(hex_str, pat)
  return { tonumber(r, 16), tonumber(g, 16), tonumber(b, 16) }
end

---@param fg string foreground color
---@param bg string background color
---@param alpha number number between 0 and 1. 0 results in bg, 1 results in fg
function util.blend(fg, bg, alpha)
  bg = hexToRgb(bg)
  fg = hexToRgb(fg)

  local blendChannel = function(i)
    local ret = (alpha * fg[i] + ((1 - alpha) * bg[i]))
    return math.floor(math.min(math.max(0, ret), 255) + 0.5)
  end

  return string.format("#%02X%02X%02X", blendChannel(1), blendChannel(2), blendChannel(3))
end

function util.darken(hex, amount, bg)
  -- Convert to RGB, reduce each channel, convert back
  local rgb = hexToRgb(hex)
  local factor = 1 - math.abs(amount)
  local darkenChannel = function(channel)
    return math.floor(math.min(math.max(0, channel * factor), 255) + 0.5)
  end
  return string.format("#%02X%02X%02X", darkenChannel(rgb[1]), darkenChannel(rgb[2]), darkenChannel(rgb[3]))
end

function util.lighten(hex, amount, fg)
  -- Convert to RGB, increase each channel towards white, convert back
  local rgb = hexToRgb(hex)
  local factor = math.abs(amount)
  local lightenChannel = function(channel)
    -- Lighten by moving towards 255 (white)
    local lightened = channel + (255 - channel) * factor
    return math.floor(math.min(math.max(0, lightened), 255) + 0.5)
  end
  return string.format("#%02X%02X%02X", lightenChannel(rgb[1]), lightenChannel(rgb[2]), lightenChannel(rgb[3]))
end

return util

