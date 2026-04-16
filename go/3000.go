package main

func areaOfMaxDiagonal(dimensions [][]int) int {
	bestArea, bestDiag := 0, 0

	for _, dim := range dimensions {
		curr := dim[0]*dim[0] + dim[1]*dim[1]

		if curr > bestDiag || (curr == bestDiag && dim[0]*dim[1] > bestArea) {
			bestDiag = curr
			bestArea = dim[0] * dim[1]
		}
	}

	return bestArea
}
