package main

func sieve(n int) []int {
	if n < 2 {
		return []int{}
	}

	isPrime := make([]bool, n+1)
	for i := 2; i <= n; i++ {
		isPrime[i] = true
	}

	for p := 2; p*p <= n; p++ {
		if isPrime[p] {
			for i := p * p; i <= n; i += p {
				isPrime[i] = false
			}
		}
	}

	primes := []int{}
	for i := 2; i <= n; i++ {
		if isPrime[i] {
			primes = append(primes, i)
		}
	}

	return primes
}

func splitArray(nums []int) int64 {
	sieve := sieve(len(nums))
	idx := 0

	var a int64 = 0
	var b int64 = 0

	for i := 0; i < len(nums); i++ {
		if idx < len(sieve) && sieve[idx] == i {
			a += int64(nums[i])
			idx++
		} else {
			b += int64(nums[i])
		}
	}

	diff := a - b
	if diff < 0 {
		diff *= -1
	}

	return diff
}
