package main

func reverseInt(num int) int {
	result := 0

	for num > 0 {
		result = (result * 10) + (num % 10)
		num /= 10
	}

	return result
}

func minMirrorPairDistance(nums []int) int {
	mp := map[int]int{}
	best := len(nums)

	for idx, num := range nums {
		prev, ok := mp[num]

		if ok && idx-prev < best {
			best = idx - prev
		}

		mp[reverseInt(num)] = idx
	}

	if best == len(nums) {
		return -1
	}

	return best
}
