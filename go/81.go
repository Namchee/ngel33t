package main

// yeah, with duplicates, i don't think it's possible to
// get lesser than O(n)
func searchTwo(nums []int, target int) bool {
	for _, num := range nums {
		if num == target {
			return true
		}
	}

	return false
}
