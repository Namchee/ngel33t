package main

func shipWithinDays(weights []int, days int) int {
	best := 0

	min := 0
	max := 0

	for _, w := range weights {
		max += w
	}

	if days == 1 {
		return max
	}

	for min <= max {
		mid := min + ((max - min) / 2)

		d := 0
		curr := 0

		lim := false

		for _, w := range weights {
			if w > mid {
				lim = true
				break
			}

			if curr+w > mid {
				curr = w
				d++
				continue
			}

			curr += w
		}

		if lim || d >= days {
			min = mid + 1
		} else {
			best = mid
			max = mid - 1
		}
	}

	return best
}
