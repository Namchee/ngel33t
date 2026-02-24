package heap

import (
	"container/heap"
	"fmt"
)

type MaxHeap []int

func (h MaxHeap) Len() int {
	return len(h)
}

func (h MaxHeap) Less(i, j int) bool {
	return h[i] > h[j]
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

func maxHeapTest() {
	h := &MaxHeap{2, 1, 5}
	heap.Init(h)
	heap.Push(h, 3)

	fmt.Println(h.Peek())
}
