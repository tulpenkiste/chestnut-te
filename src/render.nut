::Theme <- class {
	constructor(tBgCol,tTextCol,tSyntaxHighlightingCol) {
		bgCol = tBgCol
		textCol = tTextCol
		syntaxHighlightingCol = tSyntaxHighlightingCol
	}

	bgCol = null
	textCol = null
	syntaxHighlightingCol = null
}

local defaultTheme = Theme(0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF)
::currentTheme <- defaultTheme

::apMain <- function() {
	setDrawTarget(apScreen)
	setDrawColor(0x000000FF)
	drawRec(0, 0, screenRectSize[0], screenRectSize[1], true)
	drawText(apFont, 0, 0, "CPOS: " + curPos.tostring() + "\n" + files[curFile][1])
	resetDrawTarget()
	drawImage(apScreen, 0, 0)
}
