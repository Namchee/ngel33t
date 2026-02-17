package main

var cache map[int]int = map[int]int{}

func reverseBits(n int) int {
	hit, ok := cache[n]
	if ok {
		return hit
	}

	result := 0

	for _ = range 32 {
		last := (n & 1)
		result = (result << 1) | last

		n >>= 1
	}

	cache[n] = result

	return result
}
