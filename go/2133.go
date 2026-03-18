package main

func checkValid(matrix [][]int) bool {
	set := map[int]bool{}

	// check row
	for i := 0; i < len(matrix); i++ {
		for j := 0; j < len(matrix[i]); j++ {
			set[matrix[i][j]] = true
		}

		for i := 1; i <= len(matrix); i++ {
			_, ok := set[i]

			if !ok {
				return false
			}
		}

		for k := range set {
			delete(set, k)
		}
	}

	// check column
	for j := 0; j < len(matrix[0]); j++ {
		for i := 0; i < len(matrix); i++ {
			set[matrix[i][j]] = true
		}

		for i := 1; i <= len(matrix); i++ {
			_, ok := set[i]

			if !ok {
				return false
			}
		}

		for k := range set {
			delete(set, k)
		}
	}

	return true
}
