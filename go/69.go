package main

import (
	"math"
)

func mySqrt(x int) int {
	left := 0
	right := math.MaxInt32

	for left <= right {
		mid := left + (right-left)/2
		res := mid * mid

		if res == x {
			return mid
		}

		if res < x {
			left = mid + 1
		} else {
			right = mid - 1
		}
	}

	return right
}
