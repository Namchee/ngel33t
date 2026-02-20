package main

import "math"

type Node struct {
	Value int
	Next  *Node
}

func isSorted(list *Node) bool {
	prev := list.Value
	list = list.Next

	for list != nil {
		if list.Value < prev {
			return false
		}

		prev = list.Value
		list = list.Next
	}

	return true
}

func minimumPairRemoval(nums []int) int {
	head := &Node{}
	walker := head

	for _, val := range nums {
		walker.Next = &Node{Value: val}
		walker = walker.Next
	}

	head = head.Next
	op := 0

	for !isSorted(head) {
		best := head
		walker := best
		min := math.MaxInt32

		for walker != nil {
			next := walker.Next

			if next == nil {
				break
			}

			if next.Value+walker.Value < min {
				min = next.Value + walker.Value
				best = walker
			}

			walker = walker.Next
		}

		best.Value += best.Next.Value
		best.Next = best.Next.Next

		op++
	}

	return op
}
