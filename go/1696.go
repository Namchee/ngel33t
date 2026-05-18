package main

func maxResult(nums []int, k int) int {
	n := len(nums)

	result := make([]int, n)
	result[0] = nums[0]
	deque := []int{0}

	for i := 1; i < n; i++ {
		if deque[0] < i-k {
			deque = deque[1:]
		}

		result[i] = nums[i] + result[deque[0]]
		for len(deque) > 0 && result[deque[len(deque)-1]] <= result[i] {
			deque = deque[0 : len(deque)-1]
		}

		deque = append(deque, i)
	}

	return result[n-1]
}
