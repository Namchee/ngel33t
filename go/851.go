package main

func loudAndRich(richer [][]int, quiet []int) []int {
	n := len(quiet)
	ans := make([]int, n)
	indegree := make([]int, n)
	adj := make([][]int, n)
	q := []int{}

	for i := 0; i < n; i++ {
		ans[i] = i
	}

	for _, p := range richer {
		adj[p[0]] = append(adj[p[0]], p[1])

		indegree[p[1]]++
	}

	for i := 0; i < n; i++ {
		if indegree[i] == 0 {
			q = append(q, i)
		}
	}

	for len(q) > 0 {
		curr := q[0]
		q = q[1:]

		for _, neighbor := range adj[curr] {
			if quiet[ans[curr]] < quiet[ans[neighbor]] {
				ans[neighbor] = ans[curr]
			}

			indegree[neighbor]--

			if indegree[neighbor] == 0 {
				q = append(q, neighbor)
			}
		}
	}

	return ans
}
