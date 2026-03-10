package main

func maxSum(grid [][]int) int {
	result := 0

	for i := 0; i < len(grid)-2; i++ {
		for j := 0; j < len(grid[i])-2; j++ {
			temp := grid[i][j]
			temp += grid[i][j+1]
			temp += grid[i][j+2]
			temp += grid[i+1][j+1]
			temp += grid[i+2][j]
			temp += grid[i+2][j+1]
			temp += grid[i+2][j+2]

			result = max(temp, result)
		}
	}

	return result
}
