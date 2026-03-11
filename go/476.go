package main

func findComplement(num int) int {
	temp := num
	mask := 0

	for temp > 0 {
		mask = (mask << 1) | 1
		temp >>= 1
	}

	return num ^ mask
}
