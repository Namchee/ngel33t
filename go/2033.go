package main

import "slices"

func cost(arr []int, target int, mult int) int {
	c := 0

	for _, num := range arr {
		mv := (target - num) / mult
		if mv < 0 {
			mv *= -1
		}

		c += mv
	}

	return c
}

func minOperations(grid [][]int, x int) int {
	arr := []int{}

	suppose := grid[0][0] % x

	for i := 0; i < len(grid); i++ {
		for j := 0; j < len(grid[i]); j++ {
			if grid[i][j]%x != suppose {
				return -1
			}

			arr = append(arr, grid[i][j])
		}
	}

	if len(arr) == 1 {
		return 0
	}

	slices.Sort(arr)

	return cost(arr, arr[len(arr)/2], x)
}
