::Theme <- class {
	constructor(tBgCol, tTextCol) {
		bgCol = tBgCol
		textCol = tTextCol
	}

	bgCol = null
	textCol = null
	syntaxHighlightingCol = null
}

local defaultTheme = Theme(0x31363bFF, 0xFFFFFFFF)
::currentTheme <- defaultTheme

::apMain <- function() {
	setDrawTarget(apScreen)
	setDrawColor(currentTheme.bgCol)
	drawRec(0, 0, screenRectSize[0], screenRectSize[1], true)
	drawText(apFont, 0, 0, "CPOS: " + curPos.tostring() + "\nPATH: " + files[curFile][1] + "\n" + files[curFile][2])
	resetDrawTarget()
	drawImage(apScreen, 0, 0)
}
