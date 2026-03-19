package main

type Cell struct {
	count int
	valid bool
}

func numberOfSubmatrices(grid [][]byte) int {
	result := 0
	cells := make([][]Cell, len(grid))
	for i := 0; i < len(grid); i++ {
		cells[i] = make([]Cell, len(grid[i]))
	}

	for i := 0; i < len(grid); i++ {
		for j := 0; j < len(grid[i]); j++ {
			count := -1
			valid := false

			if grid[i][j] == 'X' {
				count = 1
				valid = true
			}

			if grid[i][j] == '.' {
				count = 0
				valid = false
			}

			if i > 0 {
				count += cells[i-1][j].count

				if cells[i-1][j].valid {
					valid = cells[i-1][j].valid
				}
			}

			if j > 0 {
				count += cells[i][j-1].count

				if cells[i][j-1].valid {
					valid = cells[i][j-1].valid
				}
			}

			if i > 0 && j > 0 {
				count -= cells[i-1][j-1].count
			}

			cells[i][j] = Cell{
				count: count,
				valid: valid,
			}
		}
	}

	for _, row := range cells {
		for _, col := range row {
			if col.valid && col.count == 0 {
				result++
			}
		}
	}

	return result
}
