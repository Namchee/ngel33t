package main

func maximalSquare(matrix [][]byte) int {
	table := make([][]int, len(matrix)+1)
	for idx := range table {
		table[idx] = make([]int, len(matrix[0])+1)
	}

	result := 0

	for i := 1; i <= len(matrix); i++ {
		for j := 1; j <= len(matrix[0]); j++ {
			if matrix[i-1][j-1] == '1' {
				table[i][j] = min(table[i-1][j], table[i][j-1], table[i-1][j-1]) + 1
				result = max(table[i][j], result)
			}
		}
	}

	return result * result
}
