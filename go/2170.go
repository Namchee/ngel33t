package main

func minimumOperations(nums []int) int {
	result := 0

	freq := make([][]int, 100005)
	for idx := range freq {
		freq[idx] = make([]int, 2)
	}

	for idx, val := range nums {
		freq[val][idx%2]++
	}

	bestEven := 0
	bestOdd := 0

	for i := 1; i <= 100000; i++ {
		result = max(result, freq[i][0]+bestEven, freq[i][1]+bestOdd)
		bestEven = max(bestEven, freq[i][0])
		bestOdd = max(bestOdd, freq[i][1])
	}

	return len(nums) - result
}
