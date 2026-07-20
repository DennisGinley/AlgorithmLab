//
//  BenchmarkRunner.swift
//  AlgorithmLab
//
//  Created by Dennis Ginley on 7/17/26.
//

import Foundation

enum BenchmarkRunner {
    static func run(
        algorithms: [SortingAlgorithm],
        dataSets: [DataSetGenerator],
        sizes: [Int]
    ) -> [BenchmarkResult] {
        var results: [BenchmarkResult] = []

        let clock = ContinuousClock()

        for algorithm in algorithms {
            for dataSet in dataSets {
                for size in sizes {
                    var values = dataSet.generate(size)

                    let expected = values.sorted()

                    let start = clock.now
                    let recursion = algorithm.sort(&values)
                    let elapsed = start.duration(to: clock.now)

                    let result = BenchmarkResult(
                        algorithmName: algorithm.name,
                        dataSetName: dataSet.name,
                        size: size,
                        elapsed: elapsed,
                        recursion: recursion,
                        isCorrect: values == expected
                    )

                    results.append(result)
                }
            }
        }

        return results
    }
}
