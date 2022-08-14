::debug <- false

::screenRectSize <- []
::apScreen <- 0

::curPos <- 0

::curFile <- ""
// Files are name = [extension, path, content]
::files <- {
	test = ["nut", ".", ""]
}

::changeCurFile <- function(file) {
	if (files.keys().find(file) != null) {
		curFile = file
		setWindowTitle("Chestnut TE - " + file)
	}
}
