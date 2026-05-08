package main

var cached []int

func spf21() []int {
	if cached != nil {
		return cached
	}

	spf := make([]int, 1000001)

	for i := range spf {
		spf[i] = i
	}

	for i := 2; i*1 < 1000001; i++ {
		if spf[i] == i {
			for j := i * i; j < 1000001; j += i {
				if spf[j] == j {
					spf[j] = i
				}
			}
		}
	}

	cached = spf
	return spf
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

	goodPrimes := make([]bool, maxi+1)
	for _, num := range nums {
		if num >= 2 && spf[num] == num {
			goodPrimes[num] = true
		}
	}

	teleport := map[int][]int{}
	for i := 0; i < n; i++ {
		x := nums[i]
		if x == 1 {
			continue
		}

		for x > 1 {
			p := spf[x]
			if p <= maxi && goodPrimes[p] {
				_, ok := teleport[p]
				if !ok {
					teleport[p] = []int{}
				}

				teleport[p] = append(teleport[p], i)
			}

			for x%p == 0 {
				x /= p
			}
		}
	}

	dist := make([]int, n)
	for i := 0; i < n; i++ {
		dist[i] = -1
	}

	used := make([]bool, maxi+1)

	q := []int{}
	q = append(q, 0)
	dist[0] = 0

	for len(q) > 0 {
		curr := q[0]
		q = q[1:]

		if curr == n-1 {
			return dist[curr]
		}

		// look back
		if curr-1 >= 0 && dist[curr-1] == -1 {
			dist[curr-1] = dist[curr] + 1
			q = append(q, curr-1)
		}

		// look front
		if curr+1 < n && dist[curr+1] == -1 {
			dist[curr+1] = dist[curr] + 1
			q = append(q, curr+1)
		}

		x := nums[curr]

		// prime
		if x <= maxi && x >= 2 && spf[x] == x && !used[x] {
			used[x] = true
			next, ok := teleport[x]

			if ok {
				for _, n := range next {
					if dist[n] == -1 {
						dist[n] = dist[curr] + 1
						q = append(q, n)
					}
				}
			}
		}
	}

	return -1
}
