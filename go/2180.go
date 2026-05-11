package main

func countEven(num int) int {
	result := 0

	for i := 1; i <= num; i++ {
		count := 0
		n := i

		for n > 0 {
			count += n % 10
			n /= 10
		}

		if count&1 == 0 {
			result++
		}
	}

	return result
}
