//: [Previous](@previous)

class Solution {
	func longestPalindromeSubseq(_ string: String) -> Int {
		assert(0 ... 1000 ~= string.count)
		
		let length = string.count
		if length <= 1 {
			return length
		}
		
		let characters = Array(string)
		
		var cachedResults = Array(repeating: 0, count: length * length)
		
		func calculateResult(_ leftIndex: Int, _ rightIndex: Int) -> Int {
			assert(leftIndex <= rightIndex)
			
			let cacheKey = leftIndex * length + rightIndex
			
			var result: Int = cachedResults[cacheKey]
			if result != 0 {
				return result
			}
			
			switch rightIndex - leftIndex {
				case 0:
				do {
					result = 1
				}
				
				case 1:
				do {
					if characters[leftIndex] == characters[rightIndex] {
						result = 2
					}
					else {
						result = 1
					}
				}
				
				default:
				do {
					if characters[leftIndex] == characters[rightIndex] {
						result = 2 + calculateResult(leftIndex + 1, rightIndex - 1)
					}
					else {
						result = max(calculateResult(leftIndex + 1, rightIndex), calculateResult(leftIndex, rightIndex - 1))
					}
				}
			}
			
			cachedResults[cacheKey] = result
			
			return result
		}
		
		return calculateResult(0, length - 1)
	}
}

let longestPalindromeSubseq = Solution().longestPalindromeSubseq
assert(longestPalindromeSubseq("bbbab") == 4)
assert(longestPalindromeSubseq("cbbd") == 2)

print("OK")

//: [Next](@next)
