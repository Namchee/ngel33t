package main

import (
	"container/heap"
)

type MaxHeap []int

func (h MaxHeap) Len() int {
	return len(h)
}

func (h MaxHeap) Less(i, j int) bool {
	return h[i] < h[j]
}

func (h MaxHeap) Swap(i, j int) {
	temp := h[i]
	h[i] = h[j]
	h[j] = temp
}

func (h *MaxHeap) Push(x any) {
	*h = append(*h, x.(int))
}

func (h *MaxHeap) Pop() any {
	old := *h
	n := len(old)
	x := old[n-1]
	*h = old[0 : n-1]
	return x
}

func (h *MaxHeap) Peek() any {
	return (*h)[0]
}

func nthUglyNumber(n int) int {
	h := &MaxHeap{1} // Start with 1
	heap.Init(h)

	// Track seen numbers to avoid duplicates
	seen := map[int]bool{1: true}
	factors := []int{2, 3, 5}

	val := 1
	for i := 0; i < n; i++ {
		// 1. Pop the smallest current ugly number
		val = heap.Pop(h).(int)

		// 2. Generate next possibilities
		for _, f := range factors {
			next := val * f
			if !seen[next] {
				seen[next] = true
				heap.Push(h, next)
			}
		}
	}

	return val
}
