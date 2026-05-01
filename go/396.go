package main

func bestie(a, b int) int {
	if a > b {
		return a
	}

	return b
}

func maxRotateFunction(nums []int) int {
	sum := 0
	acc := 0

	for i, num := range nums {
		sum += num
		acc += (i * num)
	}

	best := acc

	for i := 1; i < len(nums); i++ {
		acc = acc + sum - len(nums)*nums[len(nums)-i]
		best = bestie(best, acc)
	}

	return best
}
