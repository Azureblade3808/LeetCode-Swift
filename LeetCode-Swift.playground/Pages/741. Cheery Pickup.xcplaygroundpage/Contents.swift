//: [Previous](@previous)

class Solution {
	func cherryPickup(_ grid: [[Int]]) -> Int {
		assert(1 ... 50 ~= grid.count)
		assert(grid[0][0] >= 0)
		assert(grid[grid.count - 1][grid.count - 1] >= 0)
		
		let size = grid.count
		
		// Deal with size of 1 or 2 to avoid unnecessary allocation of caching
		// spaces.
		do {
			if size == 1 {
				let value = grid[0][0]
				if value >= 0 {
					return value
				}
				else {
					return 0
				}
			}
			
			if size == 2 {
				let row0 = grid[0]
				let row1 = grid[1]
				
				let value01 = row0[1]
				let value10 = row1[0]
				
				if value01 >= 0 {
					let value00 = row0[0]
					let value11 = row1[1]
					
					if value10 >= 0 {
						let result = value00 + value01 + value10 + value11
						return result
					}
					else {
						let result = value00 + value01 + value11
						return result
					}
				}
				else {
					if value10 >= 0 {
						let value00 = row0[0]
						let value11 = row1[1]
						
						let result = value00 + value10 + value11
						return result
					}
					else {
						return 0
					}
				}
			}
		}
		assert(size >= 3)
		
		let maxIndex = size - 1
		assert(maxIndex >= 2)
		
		// Calculate the partial results on last row first, because --
		// 1) The results are more probable to be used than not.
		// 2) The calculation is light-weighted and better done all at once than
		//    one by one.
		var cachedResultsFromLastRow: [Int]
		do {
			// Initiate with a sequence of -1.
			// If the iteration below is interrupted, the rest results should
			// remain -1, which means they are not accessible.
			cachedResultsFromLastRow = Array.init(repeating: -1, count: size)
			
			let lastRow = grid[maxIndex]
			var sum = 0
			for columnIndex in (0 ..< size).reversed() {
				let value = lastRow[columnIndex]
				guard value >= 0 else {
					break
				}
				
				sum += value
				cachedResultsFromLastRow[columnIndex] = sum
			}
		}
		
		func calculateResultFromLastRow(_ leftColumnIndex: Int) -> Int {
			return cachedResultsFromLastRow[leftColumnIndex]
		}
		
		var cachedResultsFromIntermediateRow: [Int : Int] = [:]
		
		func calculateResultFromIntermediateRow(
			_ rowIndex: Int,
			_ leftColumnIndex: Int,
			_ rightColumnIndex: Int
		) -> Int {
			assert(1 ..< maxIndex ~= rowIndex)
			assert(0 ..< size ~= leftColumnIndex)
			assert(leftColumnIndex ..< size ~= rightColumnIndex)
			
			let cacheKey = (rowIndex << 16) | (leftColumnIndex << 8) | rightColumnIndex
			
			if let result = cachedResultsFromIntermediateRow[cacheKey] {
				return result
			}
			
			let row = grid[rowIndex]
			let nextRowIndex = rowIndex + 1
						
			var bestResult = -1
			
			if nextRowIndex == maxIndex {
				var partialResult = 0
				
				for nextLeftColumnIndex in leftColumnIndex ..< size {
					let value = row[nextLeftColumnIndex]
					guard value >= 0 else {
						break
					}
					partialResult += value
					
					let remainingResult = calculateResultFromLastRow(nextLeftColumnIndex)
					guard remainingResult >= 0 else {
						continue
					}
					
					// At this point, `paritalResult` equals all values accumulated
					// from `leftColumnIndex` through `nextLeftColumnIndex`
					
					if nextLeftColumnIndex < rightColumnIndex {
						// Two parts in this row are NOT overlapping.
						
						var partialResult = partialResult
						
						for nextRightColumnIndex in rightColumnIndex ..< size {
							let value = row[nextRightColumnIndex]
							guard value >= 0 else {
								break
							}
							partialResult += value
							
							// At this point, `partialResult` equals all values accumulated from `leftColumnIndex`
							// through `nextLeftColumnIndex` and from `rightColumnIndex` through `nextRightColumnIndex`.
							
							let result = partialResult + remainingResult
							if result > bestResult {
								bestResult = result
							}
						}
					}
					else {
						// Two parts in this row are overlapping.
						
						// Substract the last value, to avoid checking for overlapping
						// during following iteration.
						var partialResult = partialResult - value
						
						for nextRightColumnIndex in nextLeftColumnIndex ..< size {
							let value = row[nextRightColumnIndex]
							guard value >= 0 else {
								break
							}
							partialResult += value
							
							// At this point, `partialResult` equals all values accumulated
							// from `leftColumnIndex` through `nextRightColumnIndex`.
							
							let result = partialResult + remainingResult
							if result > bestResult {
								bestResult = result
							}
						}
					}
				}
			}
			else {
				var partialResult = 0
				
				LOOP_NEXT_LEFT_COLUMN_INDEX:
				for nextLeftColumnIndex in leftColumnIndex ..< size {
					let value = row[nextLeftColumnIndex]
					guard value >= 0 else {
						break
					}
					partialResult += value
					
					// At this point, `paritalResult` equals all values accumulated
					// from `leftColumnIndex` through `nextLeftColumnIndex`
					
					if nextLeftColumnIndex < rightColumnIndex {
						// Two parts in this row are NOT overlapping.
						
						var partialResult = partialResult
						
						for nextRightColumnIndex in rightColumnIndex ..< size {
							let value = row[nextRightColumnIndex]
							guard value >= 0 else {
								break
							}
							partialResult += value
							
							// At this point, `partialResult` equals all values accumulated from `leftColumnIndex`
							// through `nextLeftColumnIndex` and from `rightColumnIndex` through `nextRightColumnIndex`.
							
							let remainingResult = calculateResultFromIntermediateRow(
								nextRowIndex, nextLeftColumnIndex, nextRightColumnIndex
							)
							guard remainingResult >= 0 else {
								continue
							}
							
							let result = partialResult + remainingResult
							if result > bestResult {
								bestResult = result
							}
						}
					}
					else {
						// Two parts in this row are overlapping.
						
						// Substract the last value, to avoid checking for overlapping
						// during following iteration.
						var partialResult = partialResult - value
						
						for nextRightColumnIndex in nextLeftColumnIndex ..< size {
							let value = row[nextRightColumnIndex]
							guard value >= 0 else {
								break
							}
							partialResult += value
							
							// At this point, `partialResult` equals all values accumulated
							// from `leftColumnIndex` through `nextRightColumnIndex`.
							
							let remainingResult = calculateResultFromIntermediateRow(
								nextRowIndex, nextLeftColumnIndex, nextRightColumnIndex
							)
							guard remainingResult >= 0 else {
								continue
							}
							
							let result = partialResult + remainingResult
							if result > bestResult {
								bestResult = result
							}
						}
					}
				}
			}
			
			cachedResultsFromIntermediateRow[cacheKey] = bestResult
			
			return bestResult
		}
		
		func calculateResultFromFirstRow() -> Int {
			let row = grid[0]
			
			var bestResult = -1
			
			var partialResult = 0
			
			for nextRightColumnIndex in 0 ..< size {
				let value = row[nextRightColumnIndex]
				guard value >= 0 else {
					break
				}
				partialResult += value
				
				for nextLeftColumnIndex in 0 ... nextRightColumnIndex {
					let remainingResult = calculateResultFromIntermediateRow(1, nextLeftColumnIndex, nextRightColumnIndex)
					guard remainingResult >= 0 else {
						continue
					}
					
					let result = partialResult + remainingResult
					if result > bestResult {
						bestResult = result
					}
				}
			}
			
			return bestResult
		}
		
		var result = calculateResultFromFirstRow()
		if result < 0 {
			result = 0
		}
		
		return result
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
