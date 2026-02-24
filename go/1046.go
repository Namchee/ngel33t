package main

import (
	"container/heap"
)

type MinHeap []int

func (h MinHeap) Len() int {
	return len(h)
}

func (h MinHeap) Less(i, j int) bool {
	return h[i] > h[j]
}

func (h MinHeap) Swap(i, j int) {
	h[i], h[j] = h[j], h[i]
}

func (h *MinHeap) Push(val any) {
	*h = append(*h, val.(int))
}

func (h *MinHeap) Pop() any {
	old := *h
	n := len(old)
	val := old[n-1]
	*h = old[0 : n-1]

	return val
}

func lastStoneWeight(stones []int) int {
	container := &MinHeap{}

	heap.Init(container)
	for _, stone := range stones {
		heap.Push(container, stone)
	}

	for container.Len() > 1 {
		a := heap.Pop(container)
		b := heap.Pop(container)

		if a != b {
			newStone := a.(int) - b.(int)
			if newStone < 0 {
				newStone = -newStone
			}

			heap.Push(container, newStone)
		}
	}

	if container.Len() == 0 {
		return 0
	}

	return heap.Pop(container).(int)
}
