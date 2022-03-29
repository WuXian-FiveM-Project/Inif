Citizen.CreateThread(function()
    local vein = exports.vein -- Store it in local variable for performance reasons
	local isChecked = false
    local windowX, windowY
    local isWindowOpened = true
	local value = 50
	local text = ""
    while isWindowOpened do
    	Citizen.Wait(0)

    	-- Call setNextWindow* methods

    	vein:beginWindow(windowX, windowY) -- Mandatory

    	-- Draw widgets in column
    	vein:beginRow()
    		-- Draw widgets in row
			isChecked = vein:checkBox(isChecked , "dawdw") -- just like react
			vein:spacing(100)
			local hasPressed = vein:button("toggle checkbox")
			if hasPressed then
				isChecked = not isChecked
			end
    	vein:endRow()

		vein:beginRow()
    		vein:dummy(0.1, 0.1)
    	vein:endRow()

		vein:beginRow()
    		vein:heading("0.1, 0.1")
			vein:label("[text]")
    	vein:endRow()

		vein:beginRow()
			_, value = vein:slider(0, value, 100,0.9)
		vein:endRow()

		_, text = vein:textEdit(text, "TEXT EDIT", 10 ,false)
		vein:progressBar(0, value, 100,0.9)
		vein:textArea(text,0.9)
		vein:separator(0.1)

		if isChecked then
        	vein:setLightColorTheme() -- set theme
		else
			vein:setDarkColorTheme() -- set theme
		end
		if vein:button("close") then 
			break
		end-- close window
    	windowX, windowY = vein:endWindow() -- Mandatory
    end
end)