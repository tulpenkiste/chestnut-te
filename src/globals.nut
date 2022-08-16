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

::inputMode <- "NONE"

::changeCurFile <- function(file) {
	if (files.keys().find(file) != null) {
		curFile = file
		if (file == "new") setWindowTitle("Chestnut TE - Untitled")
		else setWindowTitle("Chestnut TE - " + file)
	}
	else {
		print("Couldn't find " + file + "!")
	}
}

::openFile <- function(path) {
	if (!fileExists(path)) return;
	local content = fileRead(path)
	local dotIndex = 0
	local extension = null
	local pathAsArr = split(path, "/")
	local file = pathAsArr[pathAsArr.len()-1]
	local pathIndex = path.find(pathAsArr[pathAsArr.len()-2])+1
	print(pathAsArr + "\n" + pathAsArr.len() + "\n" + pathIndex)
	dotIndex = file.find(".")
	local fileWithoutExtension = file.slice(0, dotIndex)
	if (dotIndex != null) {
		extension = file.slice(dotIndex)
		files[file] <- [fileWithoutExtension, extension, path.slice(0, path.find(file)), content]
		changeCurFile(file)
	}
	else {
		files[file] <- [fileWithoutExtension, null, path.slice(0, path.find(file)), content]
		changeCurFile(file)
	}
}
