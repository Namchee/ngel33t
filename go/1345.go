package main

func minJumps2(arr []int) int {
	n := len(arr)
	if n <= 1 {
		return 0
	}

	positions := map[int][]int{}
	for idx, num := range arr {
		positions[num] = append(positions[num], idx)
	}

	steps := make([]int, n)
	for i := 0; i < n; i++ {
		steps[i] = -1
	}
	steps[0] = 0

	q := []int{0}

	for len(q) > 0 {
		curr := q[0]
		q = q[1:]

		if curr == n-1 {
			return steps[n-1]
		}

		if curr+1 < n && steps[curr+1] == -1 {
			steps[curr+1] = steps[curr] + 1
			q = append(q, curr+1)
		}

		if curr-1 >= 0 && steps[curr-1] == -1 {
			steps[curr-1] = steps[curr] + 1
			q = append(q, curr-1)
		}

		num := arr[curr]
		if nextIndices, exists := positions[num]; exists {
			for _, next := range nextIndices {
				if steps[next] == -1 {
					steps[next] = steps[curr] + 1
					q = append(q, next)
				}
			}

			delete(positions, num)
		}
	}

	return -1
}
