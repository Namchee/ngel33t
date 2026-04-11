package main

func maxi(a, b, c int) int {
	max := a
	if b > max {
		max = b
	}
	if c > max {
		max = c
	}
	return max
}

func mini(a, b, c int) int {
	min := a
	if b < min {
		min = b
	}
	if c < min {
		min = c
	}

	return min
}

func minimumDistance2(nums []int) int {
	mp := map[int][]int{}

	best := -1

	for i := 0; i < len(nums); i++ {
		val, ok := mp[nums[i]]
		if !ok {
			mp[nums[i]] = []int{-1, i}
		} else {
			if val[0] != -1 {
				a := val[0]
				b := val[1]
				c := i

				diff := 2 * (maxi(a, b, c) - mini(a, b, c))
				if best == -1 || diff < best {
					best = diff
				}
			}

			mp[nums[i]][0] = mp[nums[i]][1]
			mp[nums[i]][1] = i
		}
	}

	return best
}
