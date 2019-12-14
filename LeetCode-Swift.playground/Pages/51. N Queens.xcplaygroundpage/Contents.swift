//: [Previous](@previous)

class Solution {
	func solveNQueens(_ n: Int) -> [[String]] {
		let intArraySolutions: [[Int]] = solveNQueens(n)
		let solutions = intArraySolutions.map { intArray in
			intArray.map { index in
				"\(String(repeating: ".", count: index))Q\(String(repeating: ".", count: n - index - 1))"
			}
		}
		return solutions
	}
	
	private func solveNQueens(_ n: Int, _ columnIndexes: [Int] = []) -> [[Int]] {
		let currentRowIndex = columnIndexes.count
		
		if currentRowIndex == n {
			return [columnIndexes]
		}
		
		var solutions: [[Int]] = []
		
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
			
			solutions += solveNQueens(n, columnIndexes)
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

print("OK")

//: [Next](@next)
