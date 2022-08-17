// Themes for customising the look of chestnut-te
::Theme <- class {
	constructor(tName, tBgCol, tTextCol, fontPath) {
		themeName = tName
		bgCol = tBgCol
		textCol = tTextCol
		sprFont = newSprite(fontPath, 6, 8, 0, 0, 0, 0)
		font = newFont(sprFont, 0, 0, true, 0)
	}

	themeName = null
	bgCol = null
	textCol = null
	sprFont = null
	font = null
}

// Swap between themes
::determineTheme <- function() {
	currentThemeIndex += 1
	if (currentThemeIndex > themes.len()-1) currentThemeIndex = 0
	currentTheme = themes[currentThemeIndex]
}

// Main function for rendering
::apMain <- function() {
	setDrawTarget(apScreen)
	setDrawColor(currentTheme.bgCol)
	drawRec(0, 0, screenRectSize[0], screenRectSize[1], true)
	local output = files[curFile][3]
	if (inputMode != "CMD") output = "MODE: " + inputMode + "\n" + output
	else {
		local iniOut = output
		output = "CMD: " + cmdInput + "\nLOADED FILES: "
		foreach (key in files.keys()) {
			output += key
			if (files.keys().find(key) != files.keys().len()-1) output += ", "
		}
		output += "\n" + iniOut
	}
	if (debug) output = "THEME: " + currentTheme.themeName + "\nSCALE: " + apScale + "\nCPOS: " + curPos.tostring() + "\nPATH: " + files.keys()[files.keys().find(curFile)] + "\nFPS: " + getFPS() + "\n" + output
	drawText(currentTheme.font, 0, 0, output)
	resetDrawTarget()
	drawImage(apScreen, 0, 0)
}

::themes <- []
// Register themes
local themeList = lsdir("themes")
for (local i = 0; i < themeList.len(); i++) {
	if (themeList[i] != "." && themeList[i] != ".." && themeList[i].find(".json") != null) {
		local themeFile = mergeTable({}, jsonRead(fileRead("themes/" + themeList[i])))
		themes.insert(0, Theme(themeFile.themeName, themeFile.bgCol.tointeger(16), themeFile.textCol.tointeger(16), themeFile.fontPath))
		print("Registered theme " + themeFile.themeName + ".")
	}
}

// Make program aware of current theme
::currentThemeIndex <- 0
::currentTheme <- themes[currentThemeIndex]
