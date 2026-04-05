package main

func executeInstructions(n int, startPos []int, s string) []int {
	walker := map[byte][]int{}
	walker['R'] = []int{0, 1}
	walker['D'] = []int{1, 0}
	walker['U'] = []int{-1, 0}
	walker['L'] = []int{0, -1}

	result := []int{}

	for i := 0; i < len(s); i++ {
		row := startPos[0]
		col := startPos[1]

		ct := 0

		for j := i; j < len(s); j++ {
			row += walker[s[j]][0]
			col += walker[s[j]][1]

			if row < 0 || row >= n || col < 0 || col >= n {
				break
			}

			ct++
		}

		result = append(result, ct)
	}

	return result
}
