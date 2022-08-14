// From supertux-advance
::mergeTable <- function(a, b) {
	if(typeof a == null && typeof b == null) return null
	if(typeof a == null) return b
	if(typeof b == null) return a
	if(a == null) return b
	if(b == null) return a

	//Create new table
	local nt = clone(a)

	//Merge B table slots into A table
	foreach(slot, i in b) {
		if(!nt.rawin(slot)) nt[slot] <- i
		else if(typeof nt[slot] == "table" && typeof b[slot] == "table") nt[slot] = mergeTable(nt[slot], b[slot])
		else nt[slot] <- i
	}

	return nt
}
