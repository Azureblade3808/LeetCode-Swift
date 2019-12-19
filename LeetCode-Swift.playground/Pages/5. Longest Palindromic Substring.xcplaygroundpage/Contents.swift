//: [Previous](@previous)

class Solution {
	func longestPalindrome(_ string: String) -> String {
		assert(0 ... 1000 ~= string.count)
		
		let length = string.count
		if length <= 1 {
			return string
		}
		
		let characters = Array(string)
		
		let lengthMinusOne = length - 1
		let doubleLengthMinusTwo = lengthMinusOne + lengthMinusOne
		
		let halfLength = length / 2
		
		var palindromeLocation: Int
		var palindromeLength: Int
		
		// Keep the center index at `Double(length) / 2.0 - 0.5`, then find the
		// range of the longest palindrome.
		palindromeLocation = halfLength
		palindromeLength = length % 2
		for leftIndex in (0 ..< halfLength).reversed() {
			let rightIndex = lengthMinusOne - leftIndex;
			assert(leftIndex < rightIndex)
			assert(leftIndex + rightIndex == lengthMinusOne)
			
			if characters[leftIndex] != characters[rightIndex] {
				break
			}
			
			palindromeLocation -= 1
			palindromeLength += 2
		}
		
		// Let the center index be from `Double(length) / 2.0 - 0.5` down to 0
		// with step of -0.5 and from `Double(length) / 2.0` to `Double(length - 1)`
		// with step of 0.5, then find the range of the longest palindrome.
		for doubleCenterIndexA in (0 ..< lengthMinusOne).reversed() {
			// The real condition should be
			// `Int(centerIndexA * 2) + 1 <= palindromeLength`.
			if doubleCenterIndexA  < palindromeLength {
				break
			}
			
			let doubleCenterIndexB = doubleLengthMinusTwo - doubleCenterIndexA
			assert(doubleCenterIndexA < doubleCenterIndexB)
			assert(doubleCenterIndexA + doubleCenterIndexB == doubleLengthMinusTwo)
			
			let halfDoubleCenterIndexA = doubleCenterIndexA / 2
			
			var tempPalindromeLocation: Int
			var tempPalindromeLength: Int
			
			if doubleCenterIndexA % 2 == 0 {
				for doubleCenterIndex in [doubleCenterIndexA, doubleCenterIndexB] {
					let halfDoubleCenterIndex = doubleCenterIndex / 2
					
					tempPalindromeLocation = halfDoubleCenterIndex
					tempPalindromeLength = 1
					
					for leftIndex in stride(from: halfDoubleCenterIndex - 1, through: halfDoubleCenterIndex - halfDoubleCenterIndexA, by: -1) {
						let rightIndex = doubleCenterIndex - leftIndex
						assert(leftIndex < rightIndex)
						assert(leftIndex + rightIndex == doubleCenterIndex)
						
						if characters[leftIndex] != characters[rightIndex] {
							break
						}
						
						tempPalindromeLocation -= 1
						tempPalindromeLength += 2
					}
					
					if tempPalindromeLength > palindromeLength {
						palindromeLocation = tempPalindromeLocation
						palindromeLength = tempPalindromeLength
					}
				}
			}
			else {
				for doubleCenterIndex in [doubleCenterIndexA, doubleCenterIndexB] {
					let halfDoubleCenterIndex = doubleCenterIndex / 2
					
					tempPalindromeLocation = halfDoubleCenterIndex + 1
					tempPalindromeLength = 0
					
					for leftIndex in stride(from: halfDoubleCenterIndex, through: halfDoubleCenterIndex - halfDoubleCenterIndexA, by: -1) {
						let rightIndex = doubleCenterIndex - leftIndex
						assert(leftIndex < rightIndex)
						assert(leftIndex + rightIndex == doubleCenterIndex)
						
						if characters[leftIndex] != characters[rightIndex] {
							break
						}
						
						tempPalindromeLocation -= 1
						tempPalindromeLength += 2
					}
					
					if tempPalindromeLength > palindromeLength {
						palindromeLocation = tempPalindromeLocation
						palindromeLength = tempPalindromeLength
					}
				}
			}
		}
		
		let palindrome = String(characters[palindromeLocation ..< palindromeLocation + palindromeLength])
		
		return palindrome
	}
}

let longestPalindrome = Solution().longestPalindrome
assert(["bab", "aba"].contains(longestPalindrome("babad")))
assert(longestPalindrome("cbbd") == "bb")
assert(longestPalindrome("abb") == "bb")

print("OK")

//: [Next](@next)
