package main

func numOfUnplacedFruits(fruits []int, baskets []int) int {
	result := 0

	for i := 0; i < len(fruits); i++ {
		placed := false
		for j := 0; j < len(baskets) && !placed; j++ {
			if baskets[j] > -1 && fruits[i] <= baskets[j] {
				baskets[j] = -1
				placed = true
			}
		}

		if !placed {
			result++
		}
	}

	return result
}
