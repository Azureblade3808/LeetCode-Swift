//: [Previous](@previous)

class Solution {
	func cherryPickup(_ grid: [[Int]]) -> Int {
		assert(1 ... 50 ~= grid.count)
		assert(grid[0][0] >= 0)
		assert(grid[grid.count - 1][grid.count - 1] >= 0)
		
		let size = grid.count
		
		func calculateBestResult(
			_ previousPartialBestResult: Int,
			_ rowIndex: Int,
			_ previousLeftColumnIndex: Int,
			_ previousRightColumnIndex: Int
		) -> Int {
			assert(0 ..< size ~= rowIndex)
			
			assert(0 <= previousLeftColumnIndex)
			assert(previousLeftColumnIndex <= previousRightColumnIndex)
			assert(previousRightColumnIndex < size)
			
			let row = grid[rowIndex]
			let nextRowIndex = rowIndex + 1
			
			if nextRowIndex == size {
				var bestResult = previousPartialBestResult
				
				for columnIndex in previousLeftColumnIndex ..< size {
					let value = row[columnIndex]
					if value < 0 {
						return 0
					}
					bestResult += value
				}
				
				return bestResult
			}
			
			var bestResult = 0
			
			if rowIndex == 0 {
				assert(previousPartialBestResult == 0)
				assert(previousLeftColumnIndex == 0)
				assert(previousRightColumnIndex == 0)
				
				var partialBestResult = 0
				
				for leftColumnIndex in 0 ..< size {
					do {
						let value = row[leftColumnIndex]
						if value < 0 {
							break
						}
						partialBestResult += value
					}
					
					LOOP_RIGHT_COLUMN_INDEX:
					for rightColumnIndex in leftColumnIndex ..< size {
						var partialBestResult = partialBestResult
						
						if rightColumnIndex > leftColumnIndex {
							for columnIndex in leftColumnIndex + 1 ... rightColumnIndex {
								let value = row[columnIndex]
								if value < 0 {
									break LOOP_RIGHT_COLUMN_INDEX
								}
								partialBestResult += value
							}
						}
						
						let tempBestResult = calculateBestResult(partialBestResult, 1, leftColumnIndex, rightColumnIndex)
						if tempBestResult > bestResult {
							bestResult = tempBestResult
						}
					}
				}
			}
			else {
				var partialBestResult = previousPartialBestResult
				
				for leftColumnIndex in previousLeftColumnIndex ..< size {
					do {
						let value = row[leftColumnIndex]
						if value < 0 {
							break
						}
						partialBestResult += value
					}
					
					LOOP_RIGHT_COLUMN_INDEX:
					for rightColumnIndex in max(leftColumnIndex, previousRightColumnIndex) ..< size {
						var partialBestResult = partialBestResult
						
						do {
							if leftColumnIndex >= previousRightColumnIndex {
								if leftColumnIndex < rightColumnIndex {
									for columnIndex in leftColumnIndex + 1 ... rightColumnIndex {
										let value = row[columnIndex]
										if value < 0 {
											break LOOP_RIGHT_COLUMN_INDEX
										}
										partialBestResult += value
									}
								}
							}
							else {
								for columnIndex in previousRightColumnIndex ... rightColumnIndex {
									let value = row[columnIndex]
									if value < 0 {
										break LOOP_RIGHT_COLUMN_INDEX
									}
									partialBestResult += value
								}
							}
						}
						
						let tempBestResult = calculateBestResult(partialBestResult, nextRowIndex, leftColumnIndex, rightColumnIndex)
						if tempBestResult > bestResult {
							bestResult = tempBestResult
						}
					}
				}
			}
			
			return bestResult
		}
		
		let bestResult = calculateBestResult(0, 0, 0, 0)
		return bestResult
	}
}

let cherryPickup = Solution().cherryPickup
assert(cherryPickup([[0, 1, -1], [1, 0, -1], [1, 1,  1]]) == 5)
assert(cherryPickup([[1, 1, -1], [1, -1, 1], [-1, 1, 1]]) == 0)
assert(cherryPickup([[1, -1, -1, -1, -1], [1, 0, 1, -1, -1], [0, -1, 1, 0, 1], [1, 0, 1, 1, 0], [-1, -1, -1, 1, 1]]) == 10)
assert(cherryPickup([[1, 1, 1, 1, 1], [1, 1, -1, 1, 1], [-1, -1, 1, 1, 1], [1, 1, 1, 1, 1], [-1, 1, 1, 1, 1]]) == 13)
assert(cherryPickup([[1, 1, 1, 1, 1], [1, 1, 1, 1, 1], [-1, -1, 1, 1, -1], [1, 1, 1, 1, 1], [1, 1, 1, -1, 1]]) == 14)

print("OK")

//: [Next](@next)
