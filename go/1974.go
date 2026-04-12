package main

func roundAbs(a, b int) int {
	c := a - b
	if c < 0 {
		c *= -1
	}

	return c
}

func minTimeToType(word string) int {
	idx := 0
	curr := 0
	sec := 0

	for idx < len(word) {
		l := int(word[idx] - 'a')

		if l == curr {
			idx++
			sec++
		} else {
			cw := roundAbs(l, curr)
			ccw := 26 - roundAbs(l, curr)

			if ccw < cw {
				sec += ccw
			} else {
				sec += cw
			}

			curr = l
		}
	}

	return sec
}
