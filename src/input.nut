::handleInput <- function() {
	// Determine mode
	switch (inputMode) {
		case "CMD": {
			if (keyPress(k_escape)) {
				inputMode = "NONE"
				cmdInput = ""
				return
			}
			else if (keyPress(k_backspace)) {
				if (cmdInput.len() != 0) cmdInput = cmdInput.slice(0, cmdInput.len()-1)
			}
			if (keyPress(k_enter)) {
				cmdInput = strip(cmdInput)
				if (cmdInput == "") return
				if (cmdInput.find(" ")) {
					cmdInput = split(cmdInput, " ")
				}
				else {
					cmdInput = [cmdInput]
				}
				cmdInput[0] = cmdInput[0].tolower()
				runCMD()
			}
			local charCheck = keyString()
			if (charCheck != "") {
				cmdInput += charCheck
			}
			break
		}
		case "INSERT": {
			if (keyPress(k_escape)) {
				inputMode = "NONE"
				return
			}
			if (keyPress(k_backspace)) {
				if (curPos != 0) {
					files[curFile][3] = files[curFile][3].slice(0, files[curFile][3].len()-1)
					curPos -= 1
				}
			}
			else if (keyPress(k_enter)) {
				files[curFile][3] += "\n"
				curPos += 1
			}
			else if (keyPress(k_tab)) {
				files[curFile][3] += "\t"
				curPos += 1
			}
			else if (keyPress(k_left)) {
				curPos -= 1
				if (curPos < 0) curPos = 0
			}
			else if (keyPress(k_right)) {
				curPos += 1
				if (curPos > files[curFile][3].len()) curPos = files[curFile][3].len()
			}
			local charCheck = keyString()
			if (charCheck != "") {
				files[curFile][3] += charCheck
				curPos += 1
			}
			break
		}
		case "NONE": {
			if (keyPress(k_t)) {
				inputMode = "INSERT"
			}
			else if (keyPress(k_s)) {
				inputMode = "CMD"
			}
			break
		}
	}
	if (keyPress(k_f1)) {
		determineTheme()
	}
	if (keyPress(k_f3)) {
		debug = !debug
	}
	if (keyPress(k_f10)) {
		toggleFullscreen()
	}
	if (keyPress(k_f11)) {
		if (apScale > 1.0) apScale -= 0.25
	}
	if (keyPress(k_f12)) {
		if (apScale < 4.9) apScale += 0.25
	}
	if (keyPress(k_ralt)) {
		qSwapCurFile()
	}
}
