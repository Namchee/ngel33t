package main

func furthestDistanceFromOrigin(moves string) int {
	pos := 0
	rando := 0

	for _, move := range moves {
		if move == 'L' {
			pos++
		} else if move == 'R' {
			pos--
		} else {
			rando++
		}
	}

	if pos < 0 {
		pos -= rando
	} else {
		pos += rando
	}

	if pos < 0 {
		pos *= -1
	}

	return pos
}
