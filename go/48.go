package main

func rotate(matrix [][]int) {
	for layer := 0; layer < len(matrix)/2; layer++ {
		for idx := layer; idx < len(matrix)-1-layer; idx++ {
			// store top left
			temp := matrix[layer][idx]

			// replace top left with bottom left
			matrix[layer][idx] = matrix[len(matrix)-1-idx][layer]

			// replace bottom left with bottom right
			matrix[len(matrix)-1-idx][layer] = matrix[len(matrix)-1-layer][len(matrix)-1-idx]

			// replace bottom right with top right
			matrix[len(matrix)-1-layer][len(matrix)-1-idx] = matrix[idx][len(matrix)-1-layer]

			// replace top right with temp
			matrix[idx][len(matrix)-1-layer] = temp
		}
	}
}
