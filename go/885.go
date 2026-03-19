package main

func spiralMatrixIII(rows int, cols int, rStart int, cStart int) [][]int {
	total := rows * cols

	result := [][]int{}
	result = append(result, []int{rStart, cStart})

	i := rStart
	j := cStart

	step := 1

	for len(result) < total {
		if step%2 == 1 {
			// move right
			for ct := 0; ct < step; ct++ {
				j++

				if i >= 0 && j >= 0 && i < rows && j < cols && len(result) < total {
					result = append(result, []int{i, j})
				}
			}

			// move down
			for ct := 0; ct < step; ct++ {
				i++

				if i >= 0 && j >= 0 && i < rows && j < cols && len(result) < total {
					result = append(result, []int{i, j})
				}
			}
		} else {
			// move left
			for ct := 0; ct < step; ct++ {
				j--

				if i >= 0 && j >= 0 && i < rows && j < cols && len(result) < total {
					result = append(result, []int{i, j})
				}
			}

			// move up
			for ct := 0; ct < step; ct++ {
				i--

				if i >= 0 && j >= 0 && i < rows && j < cols && len(result) < total {
					result = append(result, []int{i, j})
				}
			}
		}

		step++
	}

	return result
}
