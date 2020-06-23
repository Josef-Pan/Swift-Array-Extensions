import UIKit
extension Array where Element: Comparable, Element: Hashable {
    /// Count unique elements of Array
    func countUniques() -> Int {
        //        let sorted = self.sorted()
        //        let initial: (Element?, Int) = (nil, 0)
        //        let reduced = sorted.reduce(initial) { ($1, $0.0 == $1 ? $0.1 : $0.1 + 1) }
        //        return reduced.1
        return self.removeAllDuplicates().count
    }
    /// Remove only adjacent duplicates from Array, keeping the first occurence
    func removeAdjacentDuplicates() -> [Element] {
        var previousElement: Element? = nil
        return reduce(into: []) { total, element in
            defer { previousElement = element }
            guard previousElement != element else { return }
            total.append(element)
        }
    }
    /// Remove all duplicate elements from Array, keeping only the first occurence
    func removeAllDuplicates()-> [Element] {
        return reduce(into: []) { total, element in
            total.contains(element) ? (): total.append(element)
        }
    }
    /// Remove all elements that are duplicating from Array, not keeping of any occurrences of repeating elements
    func removeAllDuplicatingElements()-> [Element] {
        let counts = reduce(into: [:]){ total, element in
            total[element, default:0 ] += 1
        } // let counts = reduce(into: [:]) { $0[$1, default: 0] += 1 } // Not readable
        return filter{ element in
            guard let count = counts[element] else { return false}
            return count>1 ? false : true    // Element with occurrences more than 1 are duplicating
        }
    }
    /// Test if Array has duplicates
    func hasDuplicates() ->Bool {
        let counts = reduce(into: [:]){ total, element in
            total[element, default:0 ] += 1
        }
        guard let dups =  counts.values.max() else { return false }     //Get the maximum counts of elements
        return dups > 1 ? true : false                                  //Duplicates should have count more than 1
    }
    /// Get first non repeating element from Array, may be nil
    func firstNonRepeatingElement() -> Element? {
        let counts = reduce(into: [:]){ total, element in
            total[element, default:0 ] += 1
        }
        for element in self {
            guard let count = counts[element] else { continue }
            if count == 1 {
                return element
            }
        }
        return nil
    }
    /// Test if same values in Array are adjacent or not, [ 1, 1, 2, 2 ] ->true, [ 1, 1, 2, 2, 3 ] ->true, [ 2, 1, 1, 2 ] -> false
    func isAllGrouped() ->Bool {
        let counts = removeAdjacentDuplicates().reduce(into: [:]){ total, element in
            total[element, default:0 ] += 1
        }
        for element in self {  // Now all elements should have count one, otherwise false
            guard let count = counts[element] else { continue }
            if count > 1 {
                return false
            }
        }
        return true
    }
    /// Get all combinations from Array, apply filter { $0.count ==n } to get combos of n elements
    func getAllCombinations() ->[[Element]] {
        guard count > 0 else { return [[]] }
        let tail = Array(self[1..<endIndex])    // tail contains the elements excluding the first element
        let head = self[0]                      // head contains only the first element
        let withoutHead = tail.getAllCombinations() // computing the tail's powerset
        let withHead = withoutHead.map { $0 + [head] }  // merging the head with the tail's powerset
        return withHead + withoutHead   // returning the tail's powerset and the just computed withHead array
    }
    /// Get all permuations of an array
    func getPermutations() ->[[Element]]{
        return permutations(self)
    }
    private func permutations( _ xs: [Element]) -> [[Element]] {
        guard let (head, tail) = xs.decompose() else { return [[]] }
        return permutations(tail).flatMap { between(head, $0) }
    }
    private func decompose() -> (Iterator.Element, [Iterator.Element])? {
        guard let x = first else { return nil }
        return (x, Array(self[1..<count]))
    }
    private func between (_ x: Element, _ ys: [Element]) ->[[ Element ]] {
        guard let (head, tail) = ys.decompose() else { return [[x]] }
        return [[x] + ys] + between( x, tail).map { [head] + $0 }
    }
}
