package main

import "math"

func getDivisors(num int) []int {
	divisors := []int{}

	for ct := 1; ct <= int(math.Sqrt(float64(num))); ct++ {
		if num%ct == 0 {
			divisors = append(divisors, ct)

			if num/ct != ct {
				divisors = append(divisors, num/ct)
			}
		}
	}

	return divisors
}

func sumFourDivisors(nums []int) int {
	result := 0

	for _, num := range nums {
		divisors := getDivisors(num)

		if len(divisors) == 4 {
			for _, div := range divisors {
				result += div
			}
		}
	}

	return result
}
