package main

func reverse(n int) int {
	result := 0

	for n > 0 {
		result = (result * 10) + (n % 10)
		n /= 10
	}

	return result
}

func abs(a int) int {
	if a < 0 {
		return a * -1
	}

	return a
}

func mirrorDistance(n int) int {
	rev := reverse(n)

	return abs(n - rev)
}
