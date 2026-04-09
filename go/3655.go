package main

import "math"

const RMQMod = 1e9 + 7

func binaryExponentiation(a, b, MOD int) int {
	result := 1
	for b > 0 {
		if b&1 == 1 {
			result = (result * a) % MOD
		}

		a = (a * a) % MOD
		b >>= 1
	}

	return result
}

func modInverse(a, MOD int) int {
	return binaryExponentiation(a, MOD-2, MOD)
}

func xorAfterQueries2(nums []int, queries [][]int) int {
	n := len(nums)
	m := len(queries)

	lim := int(math.Sqrt(float64(n)))

	store := make([][][][]int, lim+1)
	for i := 0; i < len(store); i++ {
		store[i] = make([][][]int, lim+1)

		for j := 0; j < len(store[i]); j++ {
			store[i][j] = [][]int{}
		}
	}

	for i := 0; i < m; i++ {
		l := queries[i][0]
		r := queries[i][1]
		k := queries[i][2]
		v := queries[i][3]

		if k >= lim {
			for idx := l; idx <= r; idx += k {
				nums[idx] = (nums[idx] * v) % RMQMod
			}
		} else {
			rem := l % k
			store[k][rem] = append(store[k][rem], []int{l, r, v})
		}
	}

	for i := 1; i < lim; i++ {
		for rem := 0; rem < i; rem++ {
			if len(store[i][rem]) == 0 {
				continue
			}

			list := store[i][rem]
			len := (n - rem + i - 1) / i

			diff := make([]int, len+1)
			for j := 0; j < len+1; j++ {
				diff[j] = 1
			}

			for _, q := range list {
				l := q[0]
				r := q[1]
				v := q[2]

				start := (l - rem) / i
				end := (r - rem) / i

				if start < 0 {
					start = 0
				}

				if end >= len {
					end = len - 1
				}

				if start > end {
					continue
				}

				diff[start] = (diff[start] * v) % RMQMod
				if end+1 < len {
					diff[end+1] = (diff[end+1] * modInverse(v, RMQMod)) % RMQMod
				}
			}

			curr := 1
			for pos := 0; pos < len; pos++ {
				curr = (curr * diff[pos]) % RMQMod

				idx := rem + pos*i
				nums[idx] = (nums[idx] * curr) % RMQMod
			}
		}
	}

	res := 0
	for i := 0; i < n; i++ {
		res ^= nums[i]
	}

	return res
}
