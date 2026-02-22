package main

func nullifyRow(matrix [][]int, row int) {
	for j := 0; j < len(matrix[row]); j++ {
		matrix[row][j] = 0
	}
}

func nullifyColumn(matrix [][]int, col int) {
	for i := 0; i < len(matrix); i++ {
		matrix[i][col] = 0
	}
}

func setZeroes(matrix [][]int) {
	rowHasZero := false
	colHasZero := false

	for j := 0; j < len(matrix[0]) && !rowHasZero; j++ {
		if matrix[0][j] == 0 {
			rowHasZero = true
		}
	}

	for i := 0; i < len(matrix) && !colHasZero; i++ {
		if matrix[i][0] == 0 {
			colHasZero = true
		}
	}

	for i := 1; i < len(matrix); i++ {
		for j := 1; j < len(matrix[i]); j++ {
			if matrix[i][j] == 0 {
				matrix[i][0] = 0
				matrix[0][j] = 0
			}
		}
	}

	for i := 1; i < len(matrix); i++ {
		if matrix[i][0] == 0 {
			nullifyRow(matrix, i)
		}
	}

	for j := 1; j < len(matrix[0]); j++ {
		if matrix[0][j] == 0 {
			nullifyColumn(matrix, j)
		}
	}

	if rowHasZero {
		nullifyRow(matrix, 0)
	}

	if colHasZero {
		nullifyColumn(matrix, 0)
	}
}
