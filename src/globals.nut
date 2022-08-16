// Application variables
::debug <- false
::apQuit <- false
::apScale <- 2.0
::apScreen <- 0
::screenRectSize <- []

// Cursor position
::curPos <- 0

::curFile <- ""
// Files are full_path = [name, extension, path, content]
::files <- {
}

// Mode can be either NONE, INSERT, CMD
::inputMode <- "NONE"
::cmdInput <- ""

::runCMD <- function() {
	// Determine command type
	switch (cmdInput[0]) {
		case "s":
			// Save file
			saveFile()
			inputMode = "NONE"
			break
		case "l":
			// Load file
			if (cmdInput[1].find("/") == null) cmdInput[1] = "./" + cmdInput[1]
			openFile(cmdInput[1])
			break
		case "c":
			// Close file
			delete files[curFile]
			if (files.keys().len() == 0) {
				print("No more files open. Closing due to a lack of newfile support.")
				apQuit = true
			}
			break
		case "q":
		case "ex":
			// Exit app
			apQuit = true
			break
		case "swp":
			// Swap to specific file. Hotkey: Right Alt Key
			changeCurFile(cmdInput[1])
			break
		case "rl":
			// Reload file
			files[curFile][3] = fileRead(files[curFile][2] + curFile)
			break
		default:
			print("Unknown command " + cmdInput + ".")
			break
	}
	cmdInput = ""
}

::changeCurFile <- function(file) {
	// Change which file in files is the active file
	if (files.keys().find(file) != null) {
		curFile = file
		if (file == "new") setWindowTitle("Chestnut TE - Untitled")
		else setWindowTitle("Chestnut TE - " + file)
		curPos = files[curFile][3].len()-1
	}
	else {
		print("Couldn't find " + file + "!")
	}
}

::qSwapCurFile <- function() {
	// Same thing as above but for hotkey
	local cIndex = files.keys().find(curFile) + 1
	if (cIndex > files.keys().len()-1) cIndex = 0
	curFile = files.keys()[cIndex]
	setWindowTitle("Chestnut TE - " + files.keys()[cIndex])
	curPos = files[curFile][3].len()-1
}

::openFile <- function(path) {
	// Opens and reads a text file on the system
	if (!fileExists(path)) return
	local pathAsArr = split(path, "/")
	if (path.find("/") == null) {
		print("Invalid path.")
		return
	}
	if (files.keys().find(pathAsArr.top()) != null) {
		print("File already open!")
		return
	}
	local content = fileRead(path)
	local dotIndex = 0
	local extension = null
	local file = pathAsArr.top()
	dotIndex = file.find(".")
	local fileWithoutExtension = file.slice(0, dotIndex)
	if (dotIndex != null) {
		extension = file.slice(dotIndex)
	}
	print("Opened file " + file + ".")
	files[file] <- [fileWithoutExtension, extension, path.slice(0, path.find(file)), content]
	changeCurFile(file)
}

::saveFile <- function() {
	// Save contents to file
	local pathToSave = files[curFile][2] + curFile
	fileWrite(pathToSave, files[curFile][3])
}
