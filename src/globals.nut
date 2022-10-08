// Application variables
::justChangedMode <- false

::curFile <- ""
// Files are full_path = [name, extension, path, content]
::files <- {
}

// Mode can be either NORMAL, INSERT, CMD
::inputMode <- "NORMAL"
::cmdInput <- ""

::runCMD <- function() {
	// Determine command type
	switch (cmdInput[0]) {
		case "s":
			// Save file
			saveFile()
			swapMode("NORMAL")
			break
		case "sa":
			if (cmdInput[1].find("/") == null) cmdInput[1] = "./" + cmdInput[1]
			saveFileAs(cmdInput[1])
			break
		case "l":
			// Load file
			if (cmdInput[1].find("/") == null) cmdInput[1] = "./" + cmdInput[1]
			openFile(cmdInput[1])
			break
		case "c":
			// Close file
			if (cmdInput.len() == 2) delete files[cmdInput[1]]
			else delete files[curFile]
			if (files.keys().len() == 0) {
				newFile()
			}
			break
		case "n":
			newFile()
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
		if (curFile != "") files[curFile][3] = textbox.text
		curFile = file
		setTextboxContent()
		if (file.slice(0, 3).find("NEW") != null) setWindowTitle("Chestnut TE - Untitled")
		else setWindowTitle("Chestnut TE - " + file)
	}
	else {
		print("Couldn't find " + file + "!")
	}
}

::qSwapCurFile <- function() {
	// Same thing as above but for hotkey
	local cIndex = files.keys().find(curFile) + 1
	if (cIndex > files.keys().len()-1) cIndex = 0
	files[curFile][3] = textbox.text
	curFile = files.keys()[cIndex]
	setTextboxContent()
	setWindowTitle("Chestnut TE - " + files.keys()[cIndex])
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
	files[path] <- [fileWithoutExtension, extension, path.slice(0, path.find(file)), content]
	changeCurFile(path)
}

::setTextboxContent <- function() {
	textbox.text = files[curFile][3];
}

::saveFile <- function() {
	// Save contents to file
	if (files[curFile][2] == null) return
	local pathToSave = files[curFile][2] + curFile
	fileWrite(pathToSave, files[curFile][3])
}

::saveFileAs <- function(path) {
	// Save contents to file using a path passed in
	local pathAsArr = split(path, "/")
	local extension = null
	local file = pathAsArr.top()
	local dotIndex = file.find(".")
	local fileWithoutExtension = file
	if (dotIndex != null) {
		extension = file.slice(dotIndex)
		fileWithoutExtension = file.slice(0, dotIndex)
	}
	files[curFile][0] = fileWithoutExtension
	files[curFile][1] = extension
	files[curFile][2] = path
	files[path] <- delete files[curFile]
	changeCurFile(path)
	fileWrite(path, files[curFile][3])
}

::swapMode <- function(mode) {
	inputMode = mode
	if (inputMode == "CMD") modeInfo.text = ": "
	else modeInfo.text = inputMode
}

::newFile <- function() {
	local filesLen = files.len()
	files["NEW" + filesLen] <- [null, null, null, "New file"]
	changeCurFile("NEW" + filesLen)
}
