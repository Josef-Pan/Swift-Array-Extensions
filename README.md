# MySwiftArrayExtensions
Very usefaul Array Extensions which I used quite often
Examples
let arrayTest = [1, 2, 3, 8, 2, 1, 5, 1, 2, 3 ]
print("arrayTest = \(arrayTest), arrayTest.firstNonRepeatingElement() = \(arrayTest.firstNonRepeatingElement())")
print("arrayTest = \(arrayTest), removeAllDuplicates() = \(arrayTest.removeAllDuplicates())")
print("arrayTest = \(arrayTest), countUniques() = \(arrayTest.removeAllDuplicates().count)")
print("arrayTest = \(arrayTest), removeAllDuplicatingElements() = \(arrayTest.removeAllDuplicatingElements())")
print("arrayTest = \(arrayTest), arrayTest.hasDuplicates() =\(arrayTest.hasDuplicates())")
print("[ 1, 1, 2, 2, 3].isAllGrouped() = \([ 1, 1, 2, 2, 3].isAllGrouped())")
print("[ 2, 1, 1, 2 ].isAllGrouped()   = \([ 2, 1, 1, 2 ].isAllGrouped())")
let combinationsOf2 = [1, 2, 3, 4].getAllCombinations().filter { $0.count == 2}
let combinationsOf3 = [1, 2, 3, 4].getAllCombinations().filter { $0.count == 3}
print("combinations 2 elements = \(combinationsOf2)")
print("combinations 3 elements = \(combinationsOf3)")
print("[ 3, 2, 1 ].getPermutations()   = \([ 3, 2, 1 ].getPermutations())")
