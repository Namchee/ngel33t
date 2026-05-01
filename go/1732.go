package main

func largestAltitude(gain []int) int {
	best := 0
	curr := 0

	for i := 0; i < len(gain); i++ {
		curr += gain[i]
		if curr > best {
			best = curr
		}
	}

	return best
}
