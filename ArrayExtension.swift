import UIKit
extension Array where Element: Comparable, Element: Hashable {
    func countUniques() -> Int {        // Count unique elements
//        let sorted = self.sorted()
//        let initial: (Element?, Int) = (nil, 0)
//        let reduced = sorted.reduce(initial) { ($1, $0.0 == $1 ? $0.1 : $0.1 + 1) }
//        return reduced.1
         return self.removeAllDuplicates().count
    }
    
    func removedAdjacentDuplicates() -> [Element] {         // Remove only adjacent duplicates, keep the first
        var previousElement: Element? = nil
        return reduce(into: []) { total, element in
            defer {
                previousElement = element
            }
            guard previousElement != element else {
                return
            }
            total.append(element)
        }
    }
    func removeAllDuplicates()-> [Element] {               // Remove all duplicate elements, keeping only the first
        return reduce(into: []) { total, element in
            total.contains(element) ? (): total.append(element)
        }
    }
    func removeAllDuplicatingElements()-> [Element] {      // Remove all elements that are duplicating, no keeping
        //let mappedItems = self.map { ($0, 1) }
        //let counts = Dictionary(mappedItems, uniquingKeysWith: +)       //Turn into dictionary with element and counts
        let counts = reduce(into: [:]){ total, element in
           total[element, default:0 ] += 1
        } // let counts = reduce(into: [:]) { $0[$1, default: 0] += 1 } // Not readable
        return filter{ element in
            guard let count = counts[element] else { return false}
            return count>1 ? false : true               // Element with occurences more than 1 are duplicating
        }
    }
    func hasDuplicates() ->Bool {
        let counts = reduce(into: [:]){ total, element in
           total[element, default:0 ] += 1
        }
        guard let dups =  counts.values.max() else { return false }     //Get the maximum counts of elements
        return dups > 1 ? true : false                                  //Duplicates should have count more than 1
    }
    func firstNonRepeatingElement() -> Element? {                       // First non repeating element or nil
        //let mappedItems = self.map { ($0, 1) }
        //let counts = Dictionary(mappedItems, uniquingKeysWith: +)     //Turn into dictionary with element and counts
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
    func isAllGrouped() ->Bool { // All same values are adjacent or not, [ 1, 1, 2, 2 ] ->true, [ 2, 1, 1, 2 ] -> false
        let mappedItems = removedAdjacentDuplicates().map { ($0, 1) }   // Ajacent duplicates removed, [ 2, 1, 2]
        let counts = Dictionary(mappedItems, uniquingKeysWith: +)       //Turn into dictionary with element and counts
        for element in self {  // Now all elements should have count one, otherwise false
            guard let count = counts[element] else { continue }
            if count > 1 {
                return false
            }
        }
        return true
    }
}
