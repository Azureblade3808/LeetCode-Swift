//: [Previous](@previous)

class Solution {
	func solveNQueens(_ n: Int) -> [[String]] {
		let solutionsAsIntArrays = solveNQueensAsIntArrays(n)
		let solutions = solutionsAsIntArrays.map { intArray in
			intArray.map { index in
				"\(String(repeating: ".", count: index))Q\(String(repeating: ".", count: n - index - 1))"
			}
		}
		return solutions
	}
	
	private func solveNQueensAsIntArrays(_ n: Int, _ columnIndexes: [Int] = []) -> [[Int]] {
		let currentRowIndex = columnIndexes.count
		
		if currentRowIndex == n {
			return [columnIndexes]
		}
		
		var solutions: [[Int]] = []
		
		LOOP_CURRENT_COLUMN_INDEX:
		for currentColumnIndex in 0 ..< n {
			for (rowIndex, columnIndex) in columnIndexes.enumerated() {
				if currentColumnIndex == columnIndex {
					continue LOOP_CURRENT_COLUMN_INDEX
				}
				
				if abs(currentColumnIndex - columnIndex) == currentRowIndex - rowIndex {
					continue LOOP_CURRENT_COLUMN_INDEX
				}
			}
			
			var columnIndexes = columnIndexes
			columnIndexes.append(currentColumnIndex)
			
			solutions += solveNQueensAsIntArrays(n, columnIndexes)
		}
		
		return solutions
	}
}

assert(
	Set(Solution().solveNQueens(4))
	==
	Set(
		[
			[".Q..", "...Q", "Q...", "..Q."],
			["..Q.", "Q...", "...Q", ".Q.."],
		]
	)
)

//: [Next](@next)
