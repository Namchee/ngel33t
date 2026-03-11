package main

func grayCode(n int) []int {
	result := []int{}

	for i := 0; i < (1 << n); i++ {
		result = append(result, i^(i>>1))
	}

	return result
}
