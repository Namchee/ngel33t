package main

func canReach2(s string, minJump int, maxJump int) bool {
	n := len(s)
	pre := 0

	table := make([]bool, n)
	table[0] = true

	for i := 1; i < n; i++ {
		if i >= minJump && table[i-minJump] {
			pre++
		}
		if i > maxJump && table[i-maxJump-1] {
			pre--
		}

		table[i] = pre > 0 && s[i] == '0'
	}

	return table[n-1]
}
