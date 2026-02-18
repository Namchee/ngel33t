package main

func hasAlternatingBits(n int) bool {
	flag := n & 1
	n >>= 1

	for n > 0 {
		last := n & 1
		if last == flag {
			return false
		}

		flag = last
		n >>= 1
	}

	return true
}
