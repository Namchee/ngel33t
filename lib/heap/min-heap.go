package heap

import (
	"container/heap"
	"fmt"
)

type MinHeap []int

func (h MinHeap) Len() int {
	return len(h)
}

func (h MinHeap) Less(i, j int) bool {
	return h[i] < h[j]
}

func (h MinHeap) Swap(i, j int) {
	temp := h[i]
	h[i] = h[j]
	h[j] = temp
}

func (h *MinHeap) Push(x any) {
	*h = append(*h, x.(int))
}

func (h *MinHeap) Pop() any {
	old := *h
	n := len(old)
	x := old[n-1]
	*h = old[0 : n-1]
	return x
}

func (h *MinHeap) Peek() any {
	return (*h)[0]
}

func minHeapTest() {
	h := &MinHeap{2, 1, 5}
	heap.Init(h)
	heap.Push(h, 3)

	fmt.Println(h.Peek())
}
