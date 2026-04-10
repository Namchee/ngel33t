package main

func missingInteger(nums []int) int {
	mp := map[int]bool{}

	for _, num := range nums {
		mp[num] = true
	}

	for i := 0; i < len(nums); i++ {
		prev := nums[i]
		sum := nums[i]

		for j := i + 1; j < len(nums); j++ {
			if nums[j]-prev == 1 {
				sum += nums[j]
				prev = nums[j]
			} else {
				break
			}
		}

		for sum > 0 {
			_, ok := mp[sum]

			if !ok {
				return sum
			}

			sum++
		}
	}

	return -1
}
