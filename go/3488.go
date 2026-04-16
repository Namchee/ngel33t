package main

func minRange(a, b int) int {
	if a > b {
		return b
	}

	return a
}

func solveQueries(nums []int, queries []int) []int {
	best := make([]int, len(nums))
	for i := 0; i < len(nums); i++ {
		best[i] = 1e15
	}

	prev := map[int]int{}
	first := map[int]int{}

	result := []int{}

	for idx, num := range nums {
		_, ok := first[num]

		if !ok {
			first[num] = idx
			prev[num] = idx
			continue
		}

		p := prev[num]
		best[p] = minRange(idx-p, best[p])
		best[idx] = idx - p

		prev[num] = idx
	}

	for k, v := range prev {
		f := first[k]
		if f == v {
			continue
		}

		circular := (f - v + len(nums)) % len(nums)

		best[f] = minRange(best[f], circular)
		best[v] = minRange(best[v], circular)
	}

	for _, q := range queries {
		if best[q] == 1e15 {
			result = append(result, -1)
			continue
		}

		result = append(result, best[q])
	}

	return result
}
