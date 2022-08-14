::handleInput <- function() {
	local check = anyKeyPress()
	if (check != -1) {
		if (keyPress(k_backspace)) {
			if (curPos != 0) {
				files[curFile][1] = files[curFile][1].slice(0, files[curFile][1].len()-1)
				curPos -= 1
			}
		}
		else if (check == k_enter) {
			files[curFile][1] += "\n"
			curPos += 1
		}
		else if (check == k_escape) {
			// Temporary feature.
			files[curFile][1] = ""
			curPos = 0
		}
		else if (check == k_left) {
			curPos -= 1
			if (curPos < 0) curPos = 0
		}
		else if (check == k_right) {
			curPos += 1
			if (curPos > files[curFile][1].len()) curPos = files[curFile][1].len()
		}
		else {
			local charCheck = keyString()
			if (charCheck != "") {
				files[curFile][1] += charCheck
				curPos += 1
			}
		}
	}
}
