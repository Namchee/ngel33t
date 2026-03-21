package main

func longestConsecutive(nums []int) int {
	mp := map[int]bool{}

	for _, num := range nums {
		mp[num] = true
	}

	ans := 0

	for key := range mp {
		prev := key - 1
		_, ok := mp[prev]

		if !ok {
			len := 1
			next := key + 1

			for true {
				_, exist := mp[next]
				if !exist {
					break
				}

				len++
				next++
			}

			ans = max(ans, len)
		}
	}

	return ans
}
