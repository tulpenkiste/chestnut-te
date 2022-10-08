::chestnutTextboxWidget <- class extends hazelTextboxWidget {
    function input(inputs) {
        // Determine mode
	   switch (inputMode) {
		  case "CMD": {
			 if (justChangedMode) {
				    if (!keyDown(k_s) && !keyRelease(k_s)) {
					   justChangedMode = false
				    }
				    else return
			 }
			 if (keyPress(k_escape)) {
				    swapMode("NORMAL")
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
			 modeInfo.text = ": " + cmdInput
			 break
		  }
		  case "INSERT": {
		      if (keyPress(k_escape)) {
		          swapMode("NORMAL")
		          cmdInput = ""
		      }
              else {
                  base.input(inputs)
              }
              break;
		  }
		  case "NORMAL": {
			if (keyPress(k_i)) {
				justChangedMode = true
				swapMode("INSERT")
			}
			else if (keyPress(k_s)) {
				justChangedMode = true
				swapMode("CMD")
			}
			break
		  }
	   }
	   if (keyPress(k_f10)) {
		  toggleFullscreen()
	   }
	   if (keyPress(k_ralt)) {
		  qSwapCurFile()
	   }
    }
}