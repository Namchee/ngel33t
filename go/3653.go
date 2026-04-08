package main

const XORMOD = 1000000007

func xorAfterQueries(nums []int, queries [][]int) int {
	for _, q := range queries {
		l := q[0]
		r := q[1]
		k := q[2]
		v := q[3]

		idx := l

		for idx < len(nums) && idx <= r {
			nums[idx] = (nums[idx] * v) % XORMOD
			idx += k
		}
	}

	target := nums[0]

	for i := 1; i < len(nums); i++ {
		target ^= nums[i]
	}

	return target
}
