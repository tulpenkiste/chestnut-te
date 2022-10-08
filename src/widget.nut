::chestnutTextboxWidget <- class extends hazelTextboxWidget {
    function input(inputs) {
        // Determine mode
	   switch (inputMode) {
		  case "CMD": {
			 if (justChangedMode) {
				    if (!keyDown(k_s) && !keyRelease(k_s)) {
					   keyString()
					   justChangedMode = false
				    }
				    else return
			 }
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
		          inputMode = NONE
		          cmdInput = ""
		      }
              else {
                  base.input()
              }
              break;
		  }
	   }
	   if (keyPress(k_f3)) {
		  debug = !debug
	   }
	   if (keyPress(k_f10)) {
		  toggleFullscreen()
	   }
    }
}