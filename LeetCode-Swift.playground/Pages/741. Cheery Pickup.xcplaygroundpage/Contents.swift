//: [Previous](@previous)

class Solution {
	func cherryPickup(_ grid: [[Int]]) -> Int {
		let size = grid.count
		assert(1 ... 50 ~= size)
		
		let maxIndex = size - 1
		
		/**
		 * @param value Value at the start point.
		 * @param x The X coordinate of the start point.
		 * @param y The Y coordinate of the start point.
		 * @returns The best result among every routes, or -1 if there is no possible route.
		 */
		func calculateBestResult(_ value: Int, _ x: Int, _ y: Int) -> Int {
			assert(value >= 0)
			assert(0 ..< size ~= x)
			assert(0 ..< size ~= y)
			
			if x < maxIndex {
				if y < maxIndex {
					let valueAtRight = grid[y][x + 1]
					let valueAtBelow = grid[y + 1][x]
					
					if valueAtRight >= 0 {
						if valueAtBelow >= 0 {
							// Try both ways.
							let bestResultFromRight = calculateBestResult(valueAtRight, x + 1, y)
							let bestResultFromBelow = calculateBestResult(valueAtBelow, x, y + 1)
							
							if bestResultFromRight >= 0 {
								if bestResultFromBelow >= 0 {
									let bestResult = value + max(
										bestResultFromRight + valueAtBelow,
										bestResultFromBelow + valueAtRight
									)
									return bestResult
								}
								else {
									let bestResult = value + bestResultFromRight + valueAtBelow
									return bestResult
								}
							}
							else {
								if bestResultFromBelow >= 0 {
									let bestResult = value + bestResultFromBelow + valueAtRight
									return bestResult
								}
								else {
									return -1
								}
							}
						}
						else {
							// The way down is blocked.
							
							// Try way right only.
							let bestResultFromRight = calculateBestResult(valueAtRight, x + 1, y)
							
							if bestResultFromRight >= 0 {
								let bestResult = value + bestResultFromRight
								return bestResult
							}
							else {
								return -1
							}
						}
					}
					else {
						// The way right is blocked.
						
						if valueAtBelow >= 0 {
							// Try way down only.
							let bestResultFromBelow = calculateBestResult(valueAtBelow, x, y + 1)
							
							if bestResultFromBelow >= 0 {
								let bestResult = value + bestResultFromBelow
								return bestResult
							}
							else {
								return -1
							}
						}
						else {
							// Both ways are blocked.
							return -1
						}
					}
				}
				else {
					// There is no way down.
					
					let valueAtRight = grid[y][x + 1]
					
					if valueAtRight >= 0 {
						// Try way right only.
						let bestResultFromRight = calculateBestResult(valueAtRight, x + 1, y)
						
						if bestResultFromRight >= 0 {
							let bestResult = value + bestResultFromRight
							return bestResult
						}
						else {
							return -1
						}
					}
					else {
						// The way right is blocked.
						return -1
					}
				}
			}
			else {
				// There is no way right.
				
				if y < maxIndex {
					let valueAtBelow = grid[y + 1][x]
					
					if valueAtBelow >= 0 {
						// Try way down only.
						let bestResultFromBelow = calculateBestResult(valueAtBelow, x, y + 1)
						
						if bestResultFromBelow >= 0 {
							let bestResult = value + bestResultFromBelow
							return bestResult
						}
						else {
							return -1
						}
					}
					else {
						// The way down is blocked.
						return -1
					}
				}
				else {
					return value
				}
			}
		}
		
		let startValue = grid[0][0]
		if startValue >= 0 {
			return calculateBestResult(startValue, 0, 0)
		}
		else {
			return -1
		}
	}
}

let cherryPickup = Solution().cherryPickup
assert(cherryPickup([[0, 1, -1], [1, 0, -1], [1, 1,  1]]) == 5)
assert(cherryPickup([[1, 1, -1], [1, -1, 1], [-1, 1, 1]]) == 0)

print("OK")

//: [Next](@next)
