package main

func greater(a, b int) int {
	if a > b {
		return a
	}

	return b
}

func replaceElements(arr []int) []int {
	right := make([]int, len(arr))

	right[len(arr)-1] = -1

	for i := len(arr) - 2; i >= 0; i-- {
		right[i] = greater(arr[i+1], right[i+1])
	}

	return right
}
