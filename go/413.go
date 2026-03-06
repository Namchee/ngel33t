package main

func numberOfArithmeticSlices(nums []int) int {
	result := 0

	var i = 2

	for ; i < len(nums); i++ {
		diff := nums[i] - nums[i-1]
		if nums[i-1]-nums[i-2] == diff {
			ct := 1
			last := nums[i]

			j := i + 1

			for ; j < len(nums); j++ {
				if nums[j]-last != diff {
					break
				}

				ct++
				last = nums[j]
			}

			i = j - 1
			result += (ct * (ct + 1)) / 2
		}

	}

	return result
}
