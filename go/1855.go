package main

func maxDis(a, b int) int {
	if a > b {
		return a
	}

	return b
}

func maxDistance(nums1 []int, nums2 []int) int {
	i := len(nums1) - 1
	j := len(nums2) - 1

	best := 0

	for i >= 0 && j >= 0 {
		if nums1[i] <= nums2[j] {
			best = maxDis(best, j-i)
			i--
		} else {
			if i == j {
				i--
			}
			j--
		}
	}

	return best
}
