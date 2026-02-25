package main

func checker(nums []int, p int, q int) bool {
	prev := -1001

	for i := 0; i <= p; i++ {
		if prev == -1001 {
			prev = nums[i]
			continue
		}

		if nums[i] <= prev {
			return false
		}

		prev = nums[i]
	}

	prev = -1001

	for i := p; i <= q; i++ {
		if prev == -1001 {
			prev = nums[i]
			continue
		}

		if nums[i] >= prev {
			return false
		}

		prev = nums[i]
	}

	prev = -1001

	for i := q; i < len(nums); i++ {
		if prev == -1001 {
			prev = nums[i]
			continue
		}

		if nums[i] <= prev {
			return false
		}

		prev = nums[i]
	}

	return true
}

func isTrionic(nums []int) bool {
	for i := 1; i < len(nums)-2; i++ {
		for j := i + 1; j < len(nums)-1; j++ {
			if checker(nums, i, j) {
				return true
			}
		}
	}

	return false
}
