package main

import (
	"math"
)

func minFlips(s string) int {
	rotation := s + s
	zeroDiff := 0
	oneDiff := 0

	best := math.MaxInt

	for i := 0; i < len(rotation); i++ {
		zeroFirst := '1'
		oneFirst := '0'

		if i%2 == 0 {
			zeroFirst = '0'
			oneFirst = '1'
		}

		if rotation[i] != byte(zeroFirst) {
			zeroDiff++
		}

		if rotation[i] != byte(oneFirst) {
			oneDiff++
		}

		if i >= len(s) {
			left := i - len(s)

			zeroLeft := '1'
			oneLeft := '0'

			if left%2 == 0 {
				zeroLeft = '0'
				oneLeft = '1'
			}

			if rotation[left] != byte(zeroLeft) {
				zeroDiff--
			}

			if rotation[left] != byte(oneLeft) {
				oneDiff--
			}
		}

		if i >= len(s)-1 {
			best = min(best, zeroDiff, oneDiff)
		}
	}

	return best
}
