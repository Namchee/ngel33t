package main

func maximum(a, b int) int {
	if a > b {
		return a
	}

	return b
}

func maxDistance2(colors []int) int {
	best := 0

	for i := 0; i < len(colors)-1; i++ {
		for j := i + 1; j < len(colors); j++ {
			if colors[i] != colors[j] {
				best = maximum(best, j-i)
			}
		}
	}

	return best
}
