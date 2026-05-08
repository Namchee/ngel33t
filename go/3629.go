package main

var cachedSPF []int

func spf21() []int {
	if cachedSPF != nil {
		return cachedSPF
	}
	s := make([]int, 1000001)
	for i := range s {
		s[i] = i
	}

	for i := 2; i*i < 1000001; i++ {
		if s[i] == i {
			for j := i * i; j < 1000001; j += i {
				if s[j] == j {
					s[j] = i
				}
			}
		}
	}
	cachedSPF = s
	return s
}

func beeg(a, b int) int {
	if a > b {
		return a
	}

	return b
}

func minJumps(nums []int) int {
	n := len(nums)
	spf := spf21()

	maxi := 0
	for _, num := range nums {
		maxi = beeg(maxi, num)
	}

	primeSeen := make([]bool, maxi+1)
	for _, x := range nums {
		if x >= 2 && x <= maxi && spf[x] == x {
			primeSeen[x] = true
		}
	}

	counts := make([]int, maxi+1)
	for _, x := range nums {
		temp := x
		if temp <= 1 {
			continue
		}
		for temp > 1 {
			p := spf[temp]
			if p <= maxi && primeSeen[p] {
				counts[p]++
			}
			for temp%p == 0 {
				temp /= p
			}
		}
	}

	offsets := make([]int, maxi+2)
	for i := 0; i <= maxi; i++ {
		offsets[i+1] = offsets[i] + counts[i]
	}

	flattened := make([]int, offsets[maxi+1])
	cp := make([]int, maxi+1)
	copy(cp, offsets)

	for i, x := range nums {
		temp := x
		if temp <= 1 {
			continue
		}
		for temp > 1 {
			p := spf[temp]
			if p <= maxi && primeSeen[p] {
				flattened[cp[p]] = i
				cp[p]++
			}
			for temp%p == 0 {
				temp /= p
			}
		}
	}

	dist := make([]int, n)
	for i := 0; i < n; i++ {
		dist[i] = -1
	}

	used := make([]bool, maxi+1)

	q := make([]int, 0, n)
	q = append(q, 0)
	dist[0] = 0
	head := 0

	for head < len(q) {
		curr := q[head]
		head++

		if curr == n-1 {
			return dist[curr]
		}

		// left
		if curr-1 >= 0 && dist[curr-1] == -1 {
			dist[curr-1] = dist[curr] + 1
			q = append(q, curr-1)
		}

		// right
		if curr+1 < n && dist[curr+1] == -1 {
			dist[curr+1] = dist[curr] + 1
			q = append(q, curr+1)
		}

		x := nums[curr]
		if x >= 2 && x <= maxi && spf[x] == x && !used[x] {
			used[x] = true
			start, end := offsets[x], offsets[x+1]
			for i := start; i < end; i++ {
				target := flattened[i]
				if dist[target] == -1 {
					dist[target] = dist[curr] + 1
					q = append(q, target)
				}
			}
		}
	}

	return -1
}
