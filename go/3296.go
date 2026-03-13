package main

import (
	"math"
)

func canFinish(targetHeight int, workerTimes []int, maxTime int64) bool {
	var totalHeight int64 = 0
	for _, t := range workerTimes {
		limit := float64(2*maxTime) / float64(t)
		k := int64((math.Sqrt(1+4*limit) - 1) / 2)
		totalHeight += k

		if totalHeight >= int64(targetHeight) {
			return true
		}
	}

	return totalHeight >= int64(targetHeight)
}

func minNumberOfSeconds(mountainHeight int, workerTimes []int) int64 {
	var left, right int64
	left = 0
	right = int64(workerTimes[0]) * int64(mountainHeight) * int64(mountainHeight+1) / 2

	for left < right {
		mid := left + (right-left)/2

		if canFinish(mountainHeight, workerTimes, mid) {
			right = mid - 1
		} else {
			left = mid + 1
		}
	}

	return right
}
