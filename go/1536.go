package main

func isValid(grid [][]int) bool {
	for i := 0; i < len(grid); i++ {
		for j := i + 1; j < len(grid); j++ {
			if grid[i][j] != 0 {
				return false
			}
		}
	}

	return true
}

func minSwaps(grid [][]int) int {
	result := 0
	maxRight := []int{}
	for _, row := range grid {
		idx := len(row) - 1

		for idx >= 0 {
			if row[idx] == 1 {
				maxRight = append(maxRight, idx)
				break
			}
		}
	}

	for i := 0; i < len(grid); i++ {
		k := -1
		for j := i; j < len(grid); j++ {
			if maxRight[j] <= i {
				result += j - i
				k = j
				break
			}
		}

		if k != -1 {
			for j := k; j > i; j-- {
				maxRight[j], maxRight[j-1] = maxRight[j-1], maxRight[j]

			}
		} else {
			return -1
		}
	}

	return result
}
