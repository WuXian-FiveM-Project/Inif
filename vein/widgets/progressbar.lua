local _context = getContext()
local _painter = _context:getPainter()
local _style = _painter:getStyle()

exports('progressBar', function(min, value, max, width)
	width = width or _context:pushWidgetWidth()

	_context:beginDraw(width, _style.widget.height)

	local h = _style.progressBar.height

	_painter:setColor(_style.color.widget)
	_painter:move(0, (_style.widget.height - h) / 2)
	_painter:drawRect(width, h)

	if value ~= min then
		local pw = value == max and width or ((value - min) / (max - min) * width)

		_painter:setColor(_style.color.progress)
		_painter:drawRect(pw, h)
	end

	_context:endDraw()
end)
