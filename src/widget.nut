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
			 else {
			 	if (keyPress(k_escape)) {
				    	swapMode("NORMAL")
				    	cmdInput.text = ""
				    	return
			 	}
			 	else if (keyPress(k_enter)) {
				    	local cmd = strip(cmdInput.text)
				    	if (cmd == "") return
				    	if (cmd.find(" ")) {
					   		cmd = split(cmd, " ")
				    	}
				    	else {
					   		cmd = [cmd]
				    	}
				    	cmd[0] = cmd[0].tolower()
				    	runCMD(cmd)
			 	}
			 	else base.input(inputs)
		     }
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