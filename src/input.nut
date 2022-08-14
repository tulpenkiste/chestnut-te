::handleInput <- function() {
	local check = anyKeyPress()
	if (check != -1) {
		if (keyPress(k_backspace)) {
			if (curPos != 0) {
				files[curFile][2] = files[curFile][2].slice(0, files[curFile][2].len()-1)
				curPos -= 1
			}
		}
		else if (keyPress(k_lalt)) {
			determineTheme()
		}
		else if (check == k_enter) {
			files[curFile][2] += "\n"
			curPos += 1
		}
		else if (check == k_escape) {
			// Temporary feature.
			files[curFile][2] = ""
			curPos = 0
		}
		else if (check == k_left) {
			curPos -= 1
			if (curPos < 0) curPos = 0
		}
		else if (check == k_right) {
			curPos += 1
			if (curPos > files[curFile][2].len()) curPos = files[curFile][2].len()
		}
		else {
			local charCheck = keyString()
			if (charCheck != "") {
				files[curFile][2] += charCheck
				curPos += 1
			}
		}
	}
}
