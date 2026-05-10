package main

func higher(a, b int) int {
	if a > b {
		return a
	}

	return b
}

func maximumJumps(nums []int, target int) int {
	table := make([]int, len(nums))
	for i := 0; i < len(nums); i++ {
		table[i] = -1
	}
	table[0] = 0

	for i := 1; i < len(nums); i++ {
		for j := 0; j < i; j++ {
			// unreachable
			if table[j] == -1 {
				continue
			}

			diff := nums[i] - nums[j]

			if diff >= -target && diff <= target {
				if table[i] == -1 {
					table[i] = table[j] + 1
				} else {
					table[i] = higher(table[i], table[j]+1)
				}
			}
		}
	}

	return table[len(nums)-1]
}
