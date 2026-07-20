//
//  BenchmarkDefinition.swift
//  AlgorithmLab
//
//  Created by Dennis Ginley on 7/17/26.
//

import Foundation

struct SortingAlgorithm: Identifiable {
    let id = UUID()
    let name: String
    let sort: (inout [Int]) -> Int
}

struct DataSetGenerator: Identifiable {
    let id = UUID()
    let name: String
    let generate: (Int) -> [Int]
}
