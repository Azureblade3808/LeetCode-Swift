//: [Previous](@previous)

class Solution {
	func calculateMinimumHP(_ dungeon: [[Int]]) -> Int {
		let height = dungeon.count
		assert(height > 0)
		
		let firstRow = dungeon[0]
		let width = firstRow.count
		assert(width > 0)
		
		var cachedBestRoutes: [Int64 : Int] = [:]
		
		func calculateBestRoute(_ x: Int, _ y: Int) -> Int {
			let cacheKey = (Int64(x) << 32) | Int64(y)
			
			if let cachedBestRoute = cachedBestRoutes[cacheKey] {
				return cachedBestRoute
			}
			
			let value = dungeon[y][x]
			
			let bestRoute: Int
			if x < width - 1 {
				if y < height - 1 {
					// Two ways.
					let bestRouteFromRight = calculateBestRoute(x + 1, y)
					let bestRouteFromBelow = calculateBestRoute(x, y + 1)
					let bestRouteFromNext = max(bestRouteFromRight, bestRouteFromBelow)
					bestRoute = min(value + bestRouteFromNext, 0)
				}
				else {
					// Way right only.
					let bestRouteFromRight = calculateBestRoute(x + 1, y)
					bestRoute = min(value + bestRouteFromRight, 0)
				}
			}
			else {
				if y < height - 1 {
					// Way down only.
					let bestRouteFromBelow = calculateBestRoute(x, y + 1)
					bestRoute = min(value + bestRouteFromBelow, 0)
				}
				else {
					bestRoute = min(value, 0)
				}
			}
			
			cachedBestRoutes[cacheKey] = bestRoute
			
			return bestRoute
		}
		let bestRoute = calculateBestRoute(0, 0)
		
		let minimumHp = 1 - min(bestRoute, 0)
		
		return minimumHp
	}
}

let calculateMinimumHP = Solution().calculateMinimumHP
assert(calculateMinimumHP([[-2, -3, 3], [-5, -10, 1], [10, 30, -5]]) == 7)
assert(calculateMinimumHP([[1, 2, 1], [-2, -3, -3], [3, 2, -2]]) == 1)

print("OK")

//: [Next](@next)
