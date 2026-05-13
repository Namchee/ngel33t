package main

func absDiff(a, b int) int {
	res := a - b
	if res < 0 {
		res *= -1
	}

	return res
}

func minMoves(nums []int, limit int) int {
	n := len(nums)
	delta := make([]int, (limit*2)+2)

	for i := 0; i < n/2; i++ {
		left := nums[i]
		right := nums[n-1-i]
		if left > right {
			left += right
			right = left - right
			left -= right
		}

		delta[2] += 2
		delta[left+1]--
		delta[left+right]--
		delta[left+right+1]++
		delta[right+limit+1]++
	}

	result := n
	moves := 0

	for i := 2; i <= limit*2; i++ {
		moves += delta[i]
		result = min(result, moves)
	}

	return result
}
