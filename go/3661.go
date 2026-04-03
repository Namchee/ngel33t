package main

import (
	"slices"
)

type ShooterRobot struct {
	pos  int
	dist int
}

// stolen from olee12, thanks for the Gist!
func LowerBound(array []int, target int) int {
	low, high, mid := 0, len(array)-1, 0

	for low <= high {
		mid = (low + high) / 2
		if array[mid] >= target {
			high = mid - 1
		} else {
			low = mid + 1
		}
	}

	return low
}

func UpperBound(array []int, target int) int {
	low, high, mid := 0, len(array)-1, 0

	for low <= high {
		mid = (low + high) / 2
		if array[mid] > target {
			high = mid - 1
		} else {
			low = mid + 1
		}
	}

	return low
}

func maxWalls(robots []int, distance []int, walls []int) int {
	shooters := []ShooterRobot{}

	for i := 0; i < len(robots); i++ {
		shooters = append(shooters, ShooterRobot{
			pos:  robots[i],
			dist: distance[i],
		})
	}

	slices.SortFunc(shooters, func(a ShooterRobot, b ShooterRobot) int {
		return a.pos - b.pos
	})
	slices.Sort(walls)

	lc := make([]int, len(robots))
	rc := make([]int, len(robots))
	common := make([]int, len(robots))

	for i := 0; i < len(robots); i++ {
		r := shooters[i]
		left_start := r.pos - r.dist
		if i > 0 && shooters[i-1].pos+1 > left_start {
			left_start = shooters[i-1].pos + 1
		}
		left_end := r.pos

		left_idx_start := LowerBound(walls, left_start)
		left_idx_end := UpperBound(walls, left_end) - 1

		if left_idx_start <= left_idx_end {
			lc[i] = left_idx_end - left_idx_start + 1
		} else {
			lc[i] = 0
		}

		right_start := r.pos
		right_end := r.pos + r.dist

		if i < len(robots)-1 && shooters[i+1].pos-1 < right_end {
			right_end = shooters[i+1].pos - 1
		}

		right_idx_start := LowerBound(walls, right_start)
		right_idx_end := UpperBound(walls, right_end) - 1

		if right_idx_start <= right_idx_end {
			rc[i] = right_idx_end - right_idx_start + 1
		} else {
			rc[i] = 0
		}
	}

	for i := 1; i < len(robots); i++ {
		prev := shooters[i-1]
		curr := shooters[i]

		prev_right_start := prev.pos
		prev_right_end := prev.pos + prev.dist

		if curr.pos-1 < prev_right_end {
			prev_right_end = curr.pos - 1
		}

		curr_left_start := curr.pos - curr.dist

		if prev.pos+1 > curr_left_start {
			curr_left_start = prev.pos + 1
		}

		curr_left_end := curr.pos

		common_start := prev_right_start
		if curr_left_start > prev_right_start {
			common_start = curr_left_start
		}

		common_end := prev_right_end
		if curr_left_end < prev_right_end {
			common_end = curr_left_end
		}

		if common_start <= common_end {
			common_idx_start := LowerBound(walls, common_start)
			common_idx_end := UpperBound(walls, common_end) - 1

			if common_idx_start <= common_idx_end {
				common[i] = common_idx_end - common_idx_start + 1
			}
		}
	}

	dp_left := make([]int, len(robots))
	dp_right := make([]int, len(robots))

	dp_left[0] = lc[0]
	dp_right[0] = rc[0]

	for i := 1; i < len(robots); i++ {
		lefto := dp_left[i-1]
		if dp_right[i-1]-common[i] > dp_left[i-1] {
			lefto = dp_right[i-1] - common[i]
		}

		dp_left[i] = lc[i] + lefto

		righto := dp_left[i-1]
		if dp_right[i-1] > dp_left[i-1] {
			righto = dp_right[i-1]
		}

		dp_right[i] = rc[i] + righto
	}

	result := dp_left[len(robots)-1]
	if dp_right[len(robots)-1] > dp_left[len(robots)-1] {
		result = dp_right[len(robots)-1]
	}

	return result
}
