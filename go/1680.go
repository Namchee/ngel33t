package main

const MODULO int = 1000000007

func calculateDigits(n int) int {
	digits := 0
	for n > 0 {
		digits++
		n >>= 1
	}

	return digits
}

func concatenatedBinary(n int) int {
	curr := 0
	for i := 1; i <= n; i++ {
		digits := calculateDigits(i)

		curr = (curr << digits) + i
		curr = curr % MODULO
	}

	return curr
}
