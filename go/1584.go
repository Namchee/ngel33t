package main

import (
	"math"
	"sort"
)

type Point struct {
	id   int
	x, y int
}

type Edge struct {
	u, v   Point
	weight float64
}

func minCostConnectPoints(points [][]int) int {
	edges := []Edge{}
	tree := make([]int, len(points))

	for i := 0; i < len(points); i++ {
		tree[i] = i
	}

	for i := 0; i < len(points)-1; i++ {
		for j := i + 1; j < len(points); j++ {
			dist := math.Abs(
				float64(points[i][0])-float64(points[j][0]),
			) + math.Abs(
				float64(points[i][1])-float64(points[j][1]),
			)

			edges = append(edges, Edge{
				u:      Point{id: i, x: points[i][0], y: points[i][1]},
				v:      Point{id: j, x: points[j][0], y: points[j][1]},
				weight: dist,
			})
		}
	}

	sort.Slice(edges, func(i, j int) bool {
		return edges[i].weight < edges[j].weight
	})

	result := 0

	for _, edge := range edges {
		if tree[edge.u.id] != tree[edge.v.id] {
			result += int(edge.weight)

			old := tree[edge.u.id]
			new := tree[edge.v.id]

			for i := 0; i < len(tree); i++ {
				if tree[i] == old {
					tree[i] = new
				}
			}
		}
	}

	return result
}
