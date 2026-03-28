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

	x := points[0][0]
	y := points[0][1]

	for i := 1; i < len(points); i++ {
		for x != points[i][0] || y != points[i][1] {
			result++
			// horizontal
			if x == points[i][0] {
				if points[i][1] < y {
					y--
				} else {
					y++
				}
				// vertical
			} else if y == points[i][1] {
				if points[i][0] < x {
					x--
				} else {
					x++
				}
				// diagonal
			} else {
				if x < points[i][0] && y < points[i][1] {
					x++
					y++
				} else if x > points[i][0] && y > points[i][1] {
					x--
					y--
				} else if x < points[i][0] && y > points[i][1] {
					x++
					y--
				} else {
					x--
					y++
				}
			}
		}
	}

	return result
}
