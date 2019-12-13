//: [Previous](@previous)

class Solution {
	func totalNQueens(_ n: Int, _ columnIndexes: [Int] = []) -> Int {
		let currentRowIndex = columnIndexes.count
		
		if currentRowIndex == n {
			return 1
		}
		
		var solutionCount: Int = 0
		
		LOOP_CURRENT_COLUMN_INDEX:
		for currentColumnIndex in 0 ..< n {
			for rowIndex in 0 ..< currentRowIndex {
				let columnIndex = columnIndexes[rowIndex]
				
				if (
					currentColumnIndex == columnIndex
					||
					abs(currentColumnIndex - columnIndex) == currentRowIndex - rowIndex
				) {
					continue LOOP_CURRENT_COLUMN_INDEX
				}
			}
			
			var columnIndexes = columnIndexes
			columnIndexes.append(currentColumnIndex)
			
			solutionCount += totalNQueens(n, columnIndexes)
		}
		
		return solutionCount
	}
}

assert(Solution().totalNQueens(1) == 1)
assert(Solution().totalNQueens(2) == 0)
assert(Solution().totalNQueens(3) == 0)
assert(Solution().totalNQueens(4) == 2)

//: [Next](@next)
