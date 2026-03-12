package main

import (
	"slices"
)

func eventualSafeNodes(graph [][]int) []int {
	sz := len(graph)
	outdegree := make([]int, sz)
	q := make([]int, 0)

	adj := make([][]int, sz)

	ans := []int{}

	for i := 0; i < sz; i++ {
		for _, neighbor := range graph[i] {
			adj[neighbor] = append(adj[neighbor], i)
		}

		outdegree[i] = len(graph[i])
	}

	for i := 0; i < sz; i++ {
		if outdegree[i] == 0 {
			q = append(q, i)
		}
	}

	for len(q) > 0 {
		top := q[0]
		q = q[1:]
		ans = append(ans, top)

		for _, neighbor := range adj[top] {
			outdegree[neighbor]--

			if outdegree[neighbor] == 0 {
				q = append(q, neighbor)
			}
		}
	}

	slices.Sort(ans)

	return ans
}
