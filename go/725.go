package main

/**
 * Definition for singly-linked list.
 * type ListNode struct {
 *     Val int
 *     Next *ListNode
 * }
 */
func splitListToParts(head *ListNode, k int) []*ListNode {
	le := 0
	runner := head

	for runner != nil {
		le++
		runner = runner.Next
	}

	bucketSize := le / k
	rem := le % k

	result := []*ListNode{}

	runner = head
	for len(result) < k {
		ct := 1

		newHead := runner

		if newHead == nil {
			result = append(result, newHead)
			continue
		}

		for runner != nil && ct < bucketSize {
			runner = runner.Next
			ct++
		}

		if rem > 0 && runner != nil && bucketSize > 0 {
			runner = runner.Next
			rem--
		}

		newRunner := runner.Next
		runner.Next = nil

		result = append(result, newHead)
		runner = newRunner
	}

	return result
}
