package main

import (
	"math"
	"slices"
)

func minAbsDiff(grid [][]int, k int) [][]int {
	result := [][]int{}

	for i := 0; i <= len(grid)-k; i++ {
		diff := []int{}
		for j := 0; j <= len(grid[i])-k; j++ {
			temp := []int{}

			for x := 0; x < k; x++ {
				for y := 0; y < k; y++ {
					temp = append(temp, grid[i+x][j+y])
				}
			}

			if k == 1 {
				diff = append(diff, 0)
			} else {
				slices.Sort(temp)
				best := math.MaxInt32

				for idx := 1; idx < len(temp); idx++ {
					if temp[idx] == temp[idx-1] {
						continue
					}

					f := temp[idx] - temp[idx-1]

					if f < 0 {
						f *= -1
					}

					best = min(best, f)
				}

				if best == math.MaxInt32 {
					diff = append(diff, 0)
				} else {
					diff = append(diff, best)
				}

			}

		}

		result = append(result, diff)
	}

	return result
}
