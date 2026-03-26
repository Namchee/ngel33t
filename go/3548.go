package main

func canPartitionGrid2(grid [][]int) bool {
	matrix := make([][]int, len(grid))
	for i := 0; i < len(grid); i++ {
		matrix[i] = make([]int, len(grid[i]))

		for j := 0; j < len(grid[i]); j++ {
			matrix[i][j] = grid[i][j]
		}
	}

	for i := 0; i < len(matrix); i++ {
		for j := 0; j < len(matrix[i]); j++ {
			if i > 0 {
				matrix[i][j] += matrix[i-1][j]
			}

			if j > 0 {
				matrix[i][j] += matrix[i][j-1]
			}

			if i > 0 && j > 0 {
				matrix[i][j] -= matrix[i-1][j-1]
			}
		}
	}

	// horizontal split
	for i := 0; i < len(grid)-1; i++ {
		a := matrix[i][len(grid[i])-1]
		b := matrix[len(grid)-1][len(grid[i])-1] - a

		if a == b {
			return true
		}

		// discount logic, for a
		if i == 0 {
			// cut the left
			a -= grid[i][0]
			if a == b {
				return true
			}
			a += grid[i][0]

			// cut the right
			a -= grid[i][len(grid[i])-1]
			if a == b {
				return true
			}
			a += grid[i][len(grid[i])-1]
		} else {
			if len(grid[0]) == 1 {
				// cut the topmost part
				a -= grid[0][0]
				if a == b {
					return true
				}

				a += grid[0][0]

				// cut the bottommest part
				a -= grid[len(grid)-1][0]
				if a == b {
					return true
				}

				a += grid[len(grid)-1][0]
			} else {
				for j := 0; j <= i; j++ {
					for k := 0; k < len(grid[j]); k++ {
						a -= grid[j][k]
						if a == b {
							return true
						}

						a += grid[j][k]
					}
				}
			}

		}

		// discount logic for b
		if i == len(grid)-2 {
			// cut the left
			b -= grid[len(grid)-1][0]
			if a == b {
				return true
			}
			b += grid[len(grid)-1][0]

			// cut the right
			b -= grid[len(grid)-1][len(grid[i])-1]
			if a == b {
				return true
			}

			b += grid[len(grid)-1][len(grid[i])-1]
		} else {
			if len(grid[0]) == 1 {
				// cut the topmost part
				b -= grid[i+1][0]
				if a == b {
					return true
				}

				b += grid[i+1][0]

				// cut the bottommost part
				b -= grid[len(grid)-1][0]
				if a == b {
					return true
				}

				b += grid[len(grid)-1][0]
			} else {
				for j := i + 1; j < len(grid); j++ {
					for k := 0; k < len(grid[j]); k++ {
						b -= grid[j][k]
						if a == b {
							return true
						}

						b += grid[j][k]
					}
				}
			}

		}
	}

	// vertical split
	for i := 0; i < len(grid[0])-1; i++ {
		a := matrix[len(grid)-1][i]
		b := matrix[len(grid)-1][len(grid[0])-1] - a

		if a == b {
			return true
		}

		// discount logic, for a
		if i == 0 {
			// cut the top
			a -= grid[0][i]
			if a == b {
				return true
			}
			a += grid[0][i]

			// cut the bottom
			a -= grid[len(grid)-1][i]
			if a == b {
				return true
			}
			a += grid[len(grid)-1][i]
		} else {
			if len(grid) == 1 {
				// cut the leftmost part
				a -= grid[0][0]
				if a == b {
					return true
				}

				a += grid[0][0]

				// cut the rightmost part
				a -= grid[0][len(grid[0])-1]
				if a == b {
					return true
				}

				a += grid[0][len(grid[0])-1]
			} else {
				for j := 0; j <= i; j++ {
					for k := 0; k < len(grid); k++ {
						a -= grid[k][j]
						if a == b {
							return true
						}

						a += grid[k][j]
					}
				}
			}
		}

		// discount logic for b
		if i == len(grid[0])-2 {
			// cut the top
			b -= grid[0][len(grid[0])-1]
			if a == b {
				return true
			}
			b += grid[0][len(grid[0])-1]

			// cut the bottom
			b -= grid[len(grid)-1][len(grid[0])-1]
			if a == b {
				return true
			}

			b += grid[len(grid)-1][len(grid[0])-1]
		} else {
			if len(grid) == 1 {
				// cut the leftmost part
				b -= grid[0][i+1]
				if a == b {
					return true
				}
				b += grid[0][i+1]

				// cut the rightmost part
				b -= grid[len(grid)-1][len(grid[0])-1]
				if a == b {
					return true
				}
				b += grid[len(grid)-1][len(grid[0])-1]
			} else {
				for j := i + 1; j < len(grid[0]); j++ {
					for k := 0; k < len(grid); k++ {
						b -= grid[k][j]
						if a == b {
							return true
						}

						b += grid[k][j]
					}
				}
			}

		}
	}

	return false
}
