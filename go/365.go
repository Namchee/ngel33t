package main

func gcd(a int, b int) int {
	if b == 0 {
		return a
	}

	return gcd(b, a%b)
}

func canMeasureWater(x int, y int, target int) bool {
	if target > x+y {
		return false
	}

	if target == 0 {
		return true
	}

	return target%gcd(x, y) == 0
}
