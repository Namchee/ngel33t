package bst

type BinaryTreeNode struct {
	Value int
	Left  *BinaryTreeNode
	Right *BinaryTreeNode
}

type BST struct {
	Root *BinaryTreeNode
}

func initTree() *BST {
	return &BST{Root: nil}
}

func (t *BST) Insert(val int) {
	newNode := &BinaryTreeNode{Value: val}
	if t.Root == nil {
		t.Root = newNode
		return
	}

	curr := t.Root
	var prev *BinaryTreeNode

	for curr != nil {
		prev = curr
		if curr.Value >= val {
			curr = curr.Left
		} else {
			curr = curr.Right
		}
	}

	if prev.Value >= val {
		prev.Left = newNode
	} else {
		prev.Right = newNode
	}
}

func (t *BST) Search(value int) bool {
	curr := t.Root

	for curr != nil {
		if curr.Value == value {
			return true
		}

		if curr.Value < value {
			curr = curr.Right
		} else {
			curr = curr.Left
		}
	}

	return false
}
