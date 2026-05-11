package main

func separateDigits(nums []int) []int {
	temp := []int{}

	for i := len(nums) - 1; i >= 0; i-- {
		num := nums[i]

		for num > 0 {
			temp = append(temp, num%10)
			num /= 10
		}
	}

	result := []int{}
	for i := len(temp) - 1; i >= 0; i-- {
		result = append(result, temp[i])
	}

	return result
}
