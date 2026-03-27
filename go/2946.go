package main

import "fmt"

func areSimilar(mat [][]int, k int) bool {
	grid := make([][]int, len(mat))
	for i := 0; i < len(mat); i++ {
		grid[i] = make([]int, len(mat[i]))
	}

	for i := 0; i < len(mat); i++ {
		if i%2 == 0 {
			for j := 0; j < len(mat[i]); j++ {
				pos := (j + k) % len(mat[i])

				grid[i][pos] = mat[i][j]
			}
		} else {
			for j := 0; j < len(mat[i]); j++ {
				pos := (((j - k) % len(mat[i])) + len(mat[i])) % len(mat[i])

				grid[i][pos] = mat[i][j]
			}
		}
	}

	for i := 0; i < len(mat); i++ {
		for j := 0; j < len(mat[i]); j++ {
			fmt.Print(grid[i][j], " ")
		}
		fmt.Print("\n")
	}

	for i := 0; i < len(mat); i++ {
		for j := 0; j < len(mat[i]); j++ {
			if mat[i][j] != grid[i][j] {
				return false
			}
		}
	}

	return true
}
