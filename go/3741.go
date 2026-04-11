package main

func minimumDistance2(nums []int) int {
	mp := map[int][]int{}

	for idx, num := range nums {
		mp[num] = append(mp[num], idx)
	}

	best := -1

	for _, v := range mp {
		for i := 0; i < len(v)-2; i++ {
			a := v[i]
			b := v[i+1]
			c := v[i+2]

			dist := b - a + c - a + c - b

			if best == -1 || dist < best {
				best = dist
			}
		}
	}

	return best
}
