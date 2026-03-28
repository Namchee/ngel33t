package main

func abs(x int) int {
	if x < 0 {
		return -x
	}
	return x
}

func max(x, y int) int {
	if x > y {
		return x
	}
	return y
}

func chebyshevDistance(a []int, b []int) int {
	return max(abs(a[0]-b[0]), abs(a[1]-b[1]))
}

func minTimeToVisitAllPoints(points [][]int) int {
	result := 0

	p := points[0]
	for i := 1; i < len(points); i++ {
		result += chebyshevDistance(p, points[i])
		p = points[i]
	}

	return result
}
