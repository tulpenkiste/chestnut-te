// From supertux-advance
::lastMouseX <- mouseX();
::lastMouseY <- mouseY();

::updateCursor <- function() {
	drawSprite(currentTheme.sprCursor, 0, mouseX(), mouseY()) //Draw the cursor.

	if(mouseX() == lastMouseX && mouseY() == lastMouseY) return; //If the cursor hasn't moved.

	lastMouseX = mouseX()
	lastMouseY = mouseY()
}
