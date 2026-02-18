package main

func firstBadVersion(n int) int {
	start := 0
	end := n

	for start <= end {
		mid := start + (end-start)/2

		if isBadVersion(mid) {
			end = mid - 1
		} else {
			start = mid + 1
		}
	}

	return start + (end-start)/2
}
