package main

func binaryGap(n int) int {
	best := 0

	ct := -1
	last := -1

	for n > 0 {
		curr := n & 1
		ct++

		n >>= 1

		if curr == 1 {
			if last == -1 {
				last = ct
				continue
			}

			best = max(ct-last, best)
			last = ct
		}
	}

	return best
}
