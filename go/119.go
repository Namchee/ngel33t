package main

func getRow(rowIdx int) []int {
	triangle := [][]int{
		[]int{1},
	}

	for i := 1; i <= rowIdx; i++ {
		row := make([]int, i+1)
		row[0] = 1
		for j := 1; j < i; j++ {
			row[j] = triangle[i-1][j-1] + triangle[i-1][j]
		}

		row[i] = 1
		triangle = append(triangle, row)
	}

	return triangle[rowIdx]
}
