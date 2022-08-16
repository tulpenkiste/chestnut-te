::debug <- false
::apQuit <- false
::apScale <- 2.0

::screenRectSize <- []
::apScreen <- 0

::curPos <- 0

::curFile <- ""
// Files are full_path = [name, extension, path, content]
::files <- {
}

// Mode can be either NONE, INSERT, CMD
::inputMode <- "NONE"
::cmdInput <- ""

::runCMD <- function() {
	switch (cmdInput[0]) {
		case "s":
			saveFile()
			inputMode = "NONE"
			break
		case "l":
			if (cmdInput[1].find("/") == null) cmdInput[1] = "./" + cmdInput[1]
			print(cmdInput[1])
			openFile(cmdInput[1])
			break
		case "q":
		case "ex":
			apQuit = true
			break
		case "swp":
			changeCurFile(cmdInput[1])
			break
		case "rl":
			files[curFile][3] = fileRead(files[curFile][2] + curFile)
			break
		default:
			print("Unknown command " + cmdInput + ".")
			break
	}
	cmdInput = ""
}

::changeCurFile <- function(file) {
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

::openFile <- function(path) {
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
	local pathToSave = files[curFile][2] + curFile
	fileWrite(pathToSave, files[curFile][3])
}
