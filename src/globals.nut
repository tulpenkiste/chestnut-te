::screenRectSize <- []
::apScreen <- 0

::curPos <- 0

::curFile <- ""
::files <- {
	test = ["nut", ""]
}

::changeCurFile <- function(file) {
	if (files.keys().find(file) != null) {
		curFile = file
		setWindowTitle("Chestnut TE - " + file)
	}
}
