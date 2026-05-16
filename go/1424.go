package main

func findDiagonalOrder(nums [][]int) []int {
	var diagonals [][]int

	for x, row := range nums {
		for y, val := range row {
			diagIndex := x + y

			for len(diagonals) <= diagIndex {
				diagonals = append(diagonals, []int{})
			}

			diagonals[diagIndex] = append(diagonals[diagIndex], val)
		}
	}

	result := []int{}

	for _, diag := range diagonals {
		for i := len(diag) - 1; i >= 0; i-- {
			result = append(result, diag[i])
		}
	}

	return result
}
