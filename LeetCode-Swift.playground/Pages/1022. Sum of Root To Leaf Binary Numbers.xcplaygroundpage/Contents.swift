//: [Previous](@previous)

class Solution {
	func sumRootToLeaf(_ root: TreeNode?) -> Int {
		guard let root = root else {
			return 0
		}
		
		var result = 0
		
		func traverse(_ node: TreeNode, _ previous: Int) {
			let value = node.val + previous
			let doubleValue = value * 2
			
			var isLeaf = true
			
			if let left = node.left {
				traverse(left, doubleValue)
				isLeaf = false
			}
			
			if let right = node.right {
				traverse(right, doubleValue)
				isLeaf = false
			}
			
			if isLeaf {
				result += value
			}
		}
		
		traverse(root, 0)
		
		return result
	}
}

class TreeNode {
	var val: Int
	var left: TreeNode?
	var right: TreeNode?

	init(_ val: Int) {
		self.val = val
		self.left = nil
		self.right = nil
	}
}

extension TreeNode {
	convenience init(_ values: [Int?]) {
		assert(values.count >= 1 && values[0] != nil)
		
		self.init(values[0]!)
		
		var values = values.dropFirst()
		var leaves: [TreeNode] = [self]
		var nextLeaves: [TreeNode]
		
		LOOP:
		while true {
			nextLeaves = []
			
			for node in leaves {
				guard values.count != 0 else {
					break LOOP
				}
				
				if let value = values.removeFirst() {
					let left = TreeNode(value)
					node.left = left
					nextLeaves.append(left)
				}
				
				guard values.count != 0 else {
					break LOOP
				}
				
				if let value = values.removeFirst() {
					let right = TreeNode(value)
					node.right = right
					nextLeaves.append(right)
				}
			}
			
			leaves = nextLeaves
		}
	}
}

let sumRootToLeaf = Solution().sumRootToLeaf
assert(sumRootToLeaf(nil) == 0)
assert(sumRootToLeaf(TreeNode([1,0,1,0,1,0,1])) == 22)

print("OK")

//: [Next](@next)
