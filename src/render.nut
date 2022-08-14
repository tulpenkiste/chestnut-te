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

::determineTheme <- function() {
	currentThemeIndex += 1
	if (currentThemeIndex > themes.len()-1) currentThemeIndex = 0
	currentTheme = themes[currentThemeIndex]
}

::apMain <- function() {
	setDrawTarget(apScreen)
	setDrawColor(currentTheme.bgCol)
	drawRec(0, 0, screenRectSize[0], screenRectSize[1], true)
	drawText(currentTheme.font, 0, 0, "THEME: " + currentTheme.themeName + "\nCPOS: " + curPos.tostring() + "\nPATH: " + files[curFile][1] + "\n" + files[curFile][2])
	resetDrawTarget()
	drawImage(apScreen, 0, 0)
}

::themes <- []
local themeList = lsdir("themes")
for (local i = 0; i < themeList.len(); i++) {
	if (themeList[i] != "." && themeList[i] != ".." && themeList[i].find(".json") != null) {
		local themeFile = mergeTable({}, jsonRead(fileRead("themes/" + themeList[i])))
		themes.append(Theme(themeFile.themeName, themeFile.bgCol.tointeger(), themeFile.textCol.tointeger(), themeFile.fontPath))
		print("Registered theme " + themeFile.themeName + ".")
	}
}

::currentThemeIndex <- 0
::currentTheme <- themes[currentThemeIndex]
