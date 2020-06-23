# MySwiftArrayExtensions
Very usefaul Array Extensions which I used quite often
Examples
let arrayTest = [1, 2, 3, 8, 2, 1, 5, 1, 2, 3 ]
print("\(String(describing: [1, 2, 3, 8, 2, 1, 5, 1, 2, 3 ].firstNonRepeatingElement()))")
print("\(arrayTest.removeAllDuplicates()), arrayTest = \(arrayTest)")
print("\(arrayTest.removeAllDuplicates().count), arrayTest = \(arrayTest)")
print("\([1, 2, 3, 8, 2, 1, 5, 1, 2].removeAllDuplicatingElements())")
print("\([3, 1, 3].hasDuplicates())")
print("\([ 1, 1, 2, 2, 3].isAllGrouped()) \([ 2, 1, 1, 2 ].isAllGrouped())")
