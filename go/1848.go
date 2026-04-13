package main

func getMinDistance(nums []int, target int, start int) int {
	best := 10001

	for idx, num := range nums {
		if num == target {
			diff := idx - start
			if diff < 0 {
				diff *= -1
			}

			best = min(best, diff)
		}
	}

	return best
}
