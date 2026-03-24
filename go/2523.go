package main

import "math"

func sievePrime(n int) []int {
	isPrime := make([]bool, n+1)

	for i := 2; i <= n; i++ {
		isPrime[i] = true
	}

	for i := 2; i*i <= n; i++ {
		if isPrime[i] {
			for ct := i * i; ct <= n; ct += i {
				isPrime[ct] = false
			}
		}
	}

	result := []int{}
	for i := 2; i <= n; i++ {
		if isPrime[i] {
			result = append(result, i)
		}
	}

	return result
}

func closestPrimes(left int, right int) []int {
	sieve := sievePrime(right)
	mini := math.MaxInt32

	best := []int{-1, -1}

	for i := 0; i < len(sieve); i++ {
		if sieve[i] >= left {
			if i+1 < len(sieve) && sieve[i+1] <= right && sieve[i+1]-sieve[i] < mini {
				best = []int{sieve[i], sieve[i+1]}
				mini = sieve[i+1] - sieve[i]
			}
		}
	}

	return best
}
