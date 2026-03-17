package main

import "slices"

func largestSubmatrix(matrix [][]int) int {
	for i := 1; i < len(matrix); i++ {
		for j := 0; j < len(matrix[i]); j++ {
			if matrix[i][j] == 1 {
				matrix[i][j] += matrix[i-1][j]
			}
		}
	}

	result := 0

	for i := 0; i < len(matrix); i++ {
		slices.SortFunc(matrix[i], func(a, b int) int {
			return b - a
		})

		for j := 0; j < len(matrix[i]); j++ {
			result = max(result, matrix[i][j]*(j+1))
		}
	}

	return result
}
