package linkedlist

type ListNode struct {
	Value int
	Next  *ListNode
}

func main() {
	head := &ListNode{}
	numbers := []int{4, 5, 7, 67, 12}
	walker := head

	for _, num := range numbers {
		walker.Next = &ListNode{Value: num}
		walker = walker.Next
	}
}
