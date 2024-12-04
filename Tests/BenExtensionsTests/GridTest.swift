@testable import BenExtensions
import Testing

struct GridTests {
    @Test func indices() async throws {
        let grid: Grid<Int> = .init([
            [1,2,3],
            [4,5,6],
        ])
        
        let expectedIndices: [Point] = [
            Point(x: 0, y: 0),
            Point(x: 1, y: 0),
            Point(x: 2, y: 0),
            Point(x: 0, y: 1),
            Point(x: 1, y: 1),
            Point(x: 2, y: 1)
        ]
                
        #expect(Array(grid.indices) == expectedIndices)
    }
    
    @Test func reversedIndices() async throws {
        let grid: Grid<Int> = .init([
            [1,2,3],
            [4,5,6],
        ])
        
        let expectedIndices: [Point] = [
            Point(x: 2, y: 1),
            Point(x: 1, y: 1),
            Point(x: 0, y: 1),
            Point(x: 2, y: 0),
            Point(x: 1, y: 0),
            Point(x: 0, y: 0)
        ]
        
        // TODO: Fix Reversed implementation
        // #expect(Array(grid.reversed().indices) == Array(expectedIndices))
    }

    @Test func sliceSubscript() async throws {
        let grid: Grid<Int> = .init([
            [1,2,3],
            [4,5,6],
            [7,8,9]
        ])
        
        
        func checkSlice(range: ClosedRange<Point>, expected: [Int]) {
            let slice = grid[range]
            print(slice)
            
            // TODO: Fix Slice Implementation
            #expect(slice.count == expected.count)
            #expect(slice.map { Int($0) } == expected)
        }
        
        checkSlice(range: Point(x: 0, y: 0)...Point(x: 0, y: 0), expected: [1])

        // TODO: Fix Slice Implementation
        // checkSlice(range: Point(x: 0, y: 0)...Point(x: 2, y: 0), expected: [1, 2, 3])
        // checkSlice(range: Point(x: 0, y: 0)...Point(x: 0, y: 1), expected: [1,4])
        // checkSlice(range: Point(x: 0, y: 0)...Point(x: 1, y: 1), expected: [1,2,4,5])
    }
    
    @Test func transposedSquare() async throws {
        let grid: Grid<Int> = .init([
            [1,2,3],
            [4,5,6],
            [7,8,9]
        ])
        
        let expected: Grid<Int> = .init([
            [1,4,7],
            [2,5,8],
            [3,6,9]
        ])
        
        #expect(grid.transposed() == expected)
        #expect(grid.transposed().transposed() == grid)
    }
    
    @Test func transposedRectangle() async throws {
        let grid: Grid<String> = .init([
            ["A","B","C","D"],
            ["E","F","G","H"],
        ])
        
        let expected: Grid<String> = .init([
            ["A","E"],
            ["B","F"],
            ["C","G"],
            ["D","H"],
        ])
        
        #expect(grid.transposed() == expected)
        #expect(grid.transposed().transposed() == grid)
    }
}
