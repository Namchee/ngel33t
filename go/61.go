package main

func rotateRight(head *ListNode, k int) *ListNode {
	if head == nil || head.Next == nil || k == 0 {
		return head
	}

	runner := head
	len := 1
	for runner.Next != nil {
		runner = runner.Next
		len++
	}

	runner.Next = head

	step := len - (k % len) - 1
	newTail := head
	for i := 0; i < step; i++ {
		newTail = newTail.Next
	}

	newHead := newTail.Next
	newTail.Next = nil

	return newHead
}
