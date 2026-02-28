package main

func visit(idx int, visited []bool, neighbor [][]int) {
	visited[idx] = true

	for i := 0; i < len(neighbor[idx]); i++ {
		if neighbor[idx][i] == 1 && !visited[i] {
			visit(i, visited, neighbor)
		}
	}
}

func findCircleNum(isConnected [][]int) int {
	visited := make([]bool, len(isConnected))
	result := 0

	for i := 0; i < len(isConnected); i++ {
		if !visited[i] {
			result++
			visit(i, visited, isConnected)
		}
	}

	return result
}
