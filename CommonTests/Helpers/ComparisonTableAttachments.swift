//
//  ComparisonTableAttachments.swift
//  Essentia
//
//  Created by Jason Cardwell on 11/29/17.
//  Copyright © 2017 Moondeer Studios. All rights reserved.
//
import Foundation
import XCTest
import Essentia
import Accelerate
@testable import SignalProcessing

/// An enumeration for specifying the general basis of an assertion.
public enum TestBasis: String {

  /// The assertion checks equality for each value ± a specified amount.
  case accuracy

  /// The assertion checks percent deviation for each value ≤ a specifed value.
  case deviation

  /// The assertion checks that the average difference ≤ a specified value.
  case differenceMean

  /// The assertion checks that the average percent deviation ≤ a specifed value.
  case percentDeviation

  /// The assertion checks that `differenceMean` or `percentDeviation` is satisfied.
  case differenceMeanOrDeviation

  /// The assertion check for absolute equality.
  case equality

}

/// Generating an attachment with a comparison of actual and expected arrays.
///
/// - Parameters:
///   - actual: The actual array of values generated by test.
///   - expected: The array of values the test expected.
///   - accuracy: The value used for accuracy/mean parameters.
///   - deviation: The value used for deviation parameters.
///   - descriptor: The descriptor to which the array values belong.
///   - results: The assertions performed and whether the assertion succeeded.
/// - Returns: An attachment with a comparison of `actual` and `expected`.
public func comparisonAttachment(with actual: [Float],
                                 expected: [Float],
                                 accuracyUsed accuracy: Float,
                                 deviationUsed deviation: Float,
                                 descriptor: String,
                                 results: [TestBasis:Bool]) -> XCTAttachment
{

  var text = ""

  appendHeader(descriptor: descriptor,
               results: results,
               accuracyUsed: accuracy,
               deviationUsed: deviation,
               target: &text)

  appendComparison(of: actual, with: expected, target: &text)

  let attachment = XCTAttachment(data: text.data(using: .utf8)!,
                                 uniformTypeIdentifier: "public.text",
                                 lifetime: .keepAlways)

  attachment.name = descriptor

  return attachment

}

/// Generating an attachment with a comparison of actual and expected arrays.
///
/// - Parameters:
///   - actual: The actual array of values generated by test.
///   - expected: The array of values the test expected.
///   - accuracy: The value used for accuracy/mean parameters.
///   - deviation: The value used for deviation parameters.
///   - descriptor: The descriptor to which the array values belong.
///   - results: The assertions performed and whether the assertion succeeded.
/// - Returns: An attachment with a comparison of `actual` and `expected`.
public func comparisonAttachment(with actual: [[Float]],
                                 expected: [[Float]],
                                 accuracyUsed accuracy: Float,
                                 deviationUsed deviation: Float,
                                 descriptor: String,
                                 results: [TestBasis:Bool]) -> XCTAttachment
{

  var text = ""

  appendHeader(descriptor: descriptor,
               results: results,
               accuracyUsed: accuracy,
               deviationUsed: deviation,
               target: &text)

  appendComparison(of: actual, with: expected, target: &text)

  let attachment = XCTAttachment(data: text.data(using: .utf8)!,
                                 uniformTypeIdentifier: "public.text",
                                 lifetime: .keepAlways)

  attachment.name = descriptor

  return attachment

}

/// Generating an attachment with a comparison of actual and expected arrays.
///
/// - Parameters:
///   - actual: The actual array of values generated by test.
///   - expected: The array of values the test expected.
///   - accuracy: The value used for accuracy/mean parameters.
///   - deviation: The value used for deviation parameters.
///   - descriptor: The descriptor to which the array values belong.
///   - results: The assertions performed and whether the assertion succeeded.
/// - Returns: An attachment with a comparison of `actual` and `expected`.
public func comparisonAttachment(with actual: [DSPComplex],
                                 expected: [DSPComplex],
                                 accuracyUsed accuracy: Float,
                                 deviationUsed deviation: Float,
                                 descriptor: String,
                                 results: [TestBasis:Bool]) -> XCTAttachment
{

  var text = ""

  appendHeader(descriptor: descriptor,
               results: results,
               accuracyUsed: accuracy,
               deviationUsed: deviation,
               target: &text)

  appendComparison(of: actual, with: expected, target: &text)

  let attachment = XCTAttachment(data: text.data(using: .utf8)!,
                                 uniformTypeIdentifier: "public.text",
                                 lifetime: .keepAlways)

  attachment.name = descriptor

  return attachment

}

/// Generating an attachment with a comparison of actual and expected arrays.
///
/// - Parameters:
///   - actual: The actual array of values generated by test.
///   - expected: The array of values the test expected.
///   - accuracy: The value used for accuracy/mean parameters.
///   - deviation: The value used for deviation parameters.
///   - descriptor: The descriptor to which the array values belong.
///   - results: The assertions performed and whether the assertion succeeded.
/// - Returns: An attachment with a comparison of `actual` and `expected`.
public func comparisonAttachment(with actual: [[DSPComplex]],
                                 expected: [[DSPComplex]],
                                 accuracyUsed accuracy: Float,
                                 deviationUsed deviation: Float,
                                 descriptor: String,
                                 results: [TestBasis:Bool]) -> XCTAttachment
{

  var text = ""

  appendHeader(descriptor: descriptor,
               results: results,
               accuracyUsed: accuracy,
               deviationUsed: deviation,
               target: &text)

  appendComparison(of: actual, with: expected, target: &text)

  let attachment = XCTAttachment(data: text.data(using: .utf8)!,
                                 uniformTypeIdentifier: "public.text",
                                 lifetime: .keepAlways)

  attachment.name = descriptor

  return attachment

}

/// Generating an attachment with a comparison of actual and expected arrays.
///
/// - Parameters:
///   - actual: The actual array of values generated by test.
///   - expected: The array of values the test expected.
///   - descriptor: The descriptor to which the array values belong.
///   - results: The assertions performed and whether the assertion succeeded.
/// - Returns: An attachment with a comparison of `actual` and `expected`.
public func comparisonAttachment(with actual: [String],
                                 expected: [String],
                                 descriptor: String,
                                 results: [TestBasis:Bool]) -> XCTAttachment
{

  var text = ""

  appendHeader(descriptor: descriptor, results: results, target: &text)

  appendComparison(of: actual, with: expected, target: &text)

  let attachment = XCTAttachment(data: text.data(using: .utf8)!,
                                 uniformTypeIdentifier: "public.text",
                                 lifetime: .keepAlways)

  attachment.name = descriptor

  return attachment

}

private let columnWidth = 18
private let zColumnWidth = columnWidth * 2
private let valueWidth = 16
private let zValueWidth = valueWidth * 2 + 2
private let indexColumnWidth = 8

private let line = "─" * (columnWidth * 4 + indexColumnWidth)
private let zLine = "─" * (zColumnWidth * 2 + columnWidth * 2 + indexColumnWidth)
private let averagesLabel = "Averages:" + " " * ((columnWidth * 2 + indexColumnWidth) - 11)
private let zAveragesLabel = "Averages:" + " " * ((zColumnWidth * 2 + indexColumnWidth) - 11)
private let spacer = " " * valueWidth
private let zSpacer = " " * zValueWidth

private let tableHeader: String = {

  let indexLabel = "Index".padded(to: indexColumnWidth, alignment: .center)
  let actualLabel = "Actual".padded(to: columnWidth, alignment: .center)
  let expectedLabel = "Expected".padded(to: columnWidth, alignment: .center)
  let differenceLabel = "Difference".padded(to: columnWidth, alignment: .center)
  let deviationLabel = "Deviation".padded(to: columnWidth, alignment: .center)

  return "\(indexLabel)\(actualLabel)\(expectedLabel)\(differenceLabel)\(deviationLabel)\n\(line)"

}()

private let zTableHeader: String = {

  let indexLabel = "Index".padded(to: indexColumnWidth, alignment: .center)
  let actualLabel = "Actual".padded(to: zColumnWidth, alignment: .center)
  let expectedLabel = "Expected".padded(to: zColumnWidth, alignment: .center)
  let differenceLabel = "Difference".padded(to: columnWidth, alignment: .center)
  let deviationLabel = "Deviation".padded(to: columnWidth, alignment: .center)

  return "\(indexLabel)\(actualLabel)\(expectedLabel)\(differenceLabel)\(deviationLabel)\n\(zLine)"

}()

/// Helper for trimming trailing zeros off of a string.
///
/// - Parameter string: The string to trim.
/// - Returns: `string` with trailing zeros dropped.
private func zeroTrimmed(_ string: String) -> String {

  guard let decimalIndex = string.index(of: ".") else { return string }

  var endIndex = string.index(decimalIndex, offsetBy: 2)

  var currentIndex = string.index(after: endIndex)

  while currentIndex != string.endIndex {

    if string[currentIndex] != "0" { endIndex = currentIndex }

    currentIndex = string.index(after: currentIndex)

  }

  return String(string[..<endIndex])

}

/// Helper for creating a formatted string from a value.
///
/// - Parameters:
///   - value: The value to format.
///   - isPercent: Whether to add a trailing `"%"` to the result.
/// - Returns: The formatted string for `value`.
private func format(value: Float, isPercent: Bool = false) -> String {
  let text = zeroTrimmed(String(format: "%.11f", value)) + (isPercent ? "%" : "")
  return text.padded(to: valueWidth, alignment: .right)
}

/// Helper for creating a formatted string from a value.
///
/// - Parameters:
///   - value: The value to format.
/// - Returns: The formatted string for `value`.
private func format(value: DSPComplex) -> String {

  let real = zeroTrimmed(String(format: "%.11f", value.real))
  let imag = zeroTrimmed(String(format: "%+.11f", value.imag))

  let text = "\(real)\(imag)i"

  return text.padded(to: zValueWidth, alignment: .right)

}

/// Helper for creating a formatted string for an index.
///
/// - Parameter index: The index to format.
/// - Returns: The formatted string for `index`.
private func format(index: Int) -> String {
  return index.description.padded(to: indexColumnWidth - 2, alignment: .right, padCharacter: " ")
}

/// Helper that appends the header information for the comparison table.
///
/// - Parameters:
///   - descriptor: Descriptive name for identifying the compared content.
///   - results: The assertions performed and whether the assertion succeeded.
///   - accuracy: The accuracy value used in the assertions or `nil`.
///   - deviation: The deviation value used in the assertions or `nil`.
///   - target: The output stream to which the text will be written.
private func appendHeader<T>(descriptor: String,
                             results: [TestBasis:Bool],
                             accuracyUsed accuracy: Float? = nil,
                             deviationUsed deviation: Float? = nil,
                             target: inout T)
  where T: TextOutputStream
{

  var passedTests: [TestBasis] = [], failedTests: [TestBasis] = []
  var includeAccuracy = false, includeDeviation = false

  for (basis, result) in results {
    if result { passedTests.append(basis) } else { failedTests.append(basis) }
    switch basis {
      case .accuracy, .differenceMean:        includeAccuracy = true
      case .deviation, .percentDeviation:     includeDeviation = true
      case .differenceMeanOrDeviation: includeAccuracy = true; includeDeviation = true
      case .equality:                         continue
    }
  }

  print("Comparison of actual/expected values for descriptor '\(descriptor)':\n\n", to: &target)

  if includeAccuracy, let accuracy = accuracy {
    print("Accuracy value used during tests: \(accuracy)", to: &target)
  }

  if includeDeviation, let deviation = deviation {
    print("Deviation value used during tests: \(deviation)%", to: &target)
  }

  if includeAccuracy || includeDeviation {
    print("", to: &target)
  }

  if !passedTests.isEmpty {
    print("Passed:", passedTests.map(\.rawValue).joined(separator: ", "), to: &target)
  }

  if !failedTests.isEmpty {
    print("Failed:", failedTests.map(\.rawValue).joined(separator: ", "), to: &target)
  }

  if !(passedTests.isEmpty && failedTests.isEmpty) { print("", to: &target) }

}

/// Helper that appends a two column table comparing actual and expected arrays.
///
/// - Parameters:
///   - array1: The first array.
///   - array2: The second array.
///   - target: The output stream to which the text will be written.
private func appendComparison<T>(of array1: [Float], with array2: [Float], target: inout T)
  where T:TextOutputStream
{

  print(tableHeader, to: &target)

  for (index, (value1, value2)) in zip(array1, array2).enumerated() {

    print(format(index: index),
          format(value: value1),
          format(value: value2),
          format(value: abs(value2 - value1)),
          format(value: value1.deviation(from: value2), isPercent: true),
          separator: "  ",
          to: &target)

  }

  if array1.count > array2.count {

    for (index, value) in zip(array2.count..<array1.count, array1[array2.count...]) {

      print(format(index: index), format(value: value), separator: "  ", to: &target)

    }

  } else if array2.count > array1.count {

    for (index, value) in zip(array1.count..<array2.count, array2[array1.count...]) {

      print(format(index: index),
            spacer,
            format(value: value),
            separator: "  ",
            to: &target)

    }

  } else {

    print(line, to: &target)
    print(averagesLabel,
          format(value: array1.averageDifference(with: array2)),
          format(value: array1.averageDeviation(from: array2), isPercent: true),
          separator: "  ",
          to: &target)

  }

}

/// Helper that appends a two column tables comparing actual and expected arrays of arrays.
///
/// - Parameters:
///   - array1: The first array.
///   - array2: The second array.
///   - target: The output stream to which the text will be written.
private func appendComparison<T>(of array1: [[Float]],
                                 with array2: [[Float]],
                                 target: inout T)
  where T:TextOutputStream
{

  for (index, (subarray1, subarray2)) in zip(array1, array2).enumerated() {

    print("Subarray index: \(index)\n", to: &target)

    appendComparison(of: subarray1, with: subarray2, target: &target)

    print("", to: &target)

  }

  if array1.count > array2.count {

    for (index, subarray) in zip(array2.count..<array1.count, array1[array2.count...]) {

      print("Subarray index: \(index)", to: &target)
      appendComparison(of: subarray, with: [], target: &target)

    }

  } else if array2.count > array1.count {

    for (index, subarray) in zip(array1.count..<array2.count, array2[array1.count...]) {

      print("Subarray index: \(index)", to: &target)
      appendComparison(of: [], with: subarray, target: &target)

    }

  } else {

    var averageDifferences: [Float] = []
    var averageDeviations: [Float] = []

    for (subarray1, subarray2) in zip(array1, array2) {
      averageDifferences.append(subarray1.averageDifference(with: subarray2))
      averageDeviations.append(subarray1.averageDeviation(from: subarray2))
    }

    print("", to: &target)
    print("Average difference for array:\(format(value: averageDifferences.mean))", to: &target)
    print("Average deviation for array:\(format(value: averageDeviations.mean, isPercent: true))",
      to: &target)

  }

}

/// Helper that appends a two column table comparing actual and expected arrays.
///
/// - Parameters:
///   - array1: The first array.
///   - array2: The second array.
///   - target: The output stream to which the text will be written.
private func appendComparison<T>(of array1: [DSPComplex], with array2: [DSPComplex], target: inout T)
  where T:TextOutputStream
{

  print(zTableHeader, to: &target)

  for (index, (value1, value2)) in zip(array1, array2).enumerated() {

    print(format(index: index),
          format(value: value1),
          format(value: value2),
          format(value: (abs(value2.real - value1.real) + abs(value2.imag - value1.imag)) / 2),
          format(value: value1.deviation(from: value2), isPercent: true),
          separator: "  ",
          to: &target)

  }

  if array1.count > array2.count {

    for (index, value) in zip(array2.count..<array1.count, array1[array2.count...]) {

      print(format(index: index), format(value: value), separator: "  ", to: &target)

    }

  } else if array2.count > array1.count {

    for (index, value) in zip(array1.count..<array2.count, array2[array1.count...]) {

      print(format(index: index),
            zSpacer,
            format(value: value),
            separator: "  ",
            to: &target)

    }

  } else {

    print(zLine, to: &target)
    print(zAveragesLabel,
          format(value: array1.averageDifference(with: array2)),
          format(value: array1.averageDeviation(from: array2), isPercent: true),
          separator: "  ",
          to: &target)

  }

}

/// Helper that appends a two column tables comparing actual and expected arrays of arrays.
///
/// - Parameters:
///   - array1: The first array.
///   - array2: The second array.
///   - target: The output stream to which the text will be written.
private func appendComparison<T>(of array1: [[DSPComplex]],
                                 with array2: [[DSPComplex]],
                                 target: inout T)
  where T:TextOutputStream
{

  for (index, (subarray1, subarray2)) in zip(array1, array2).enumerated() {

    print("Subarray index: \(index)\n", to: &target)

    appendComparison(of: subarray1, with: subarray2, target: &target)

    print("", to: &target)

  }

  if array1.count > array2.count {

    for (index, subarray) in zip(array2.count..<array1.count, array1[array2.count...]) {

      print("Subarray index: \(index)", to: &target)
      appendComparison(of: subarray, with: [], target: &target)

    }

  } else if array2.count > array1.count {

    for (index, subarray) in zip(array1.count..<array2.count, array2[array1.count...]) {

      print("Subarray index: \(index)", to: &target)
      appendComparison(of: [], with: subarray, target: &target)

    }

  } else {

    var averageDifferences: [Float] = []
    var averageDeviations: [Float] = []

    for (subarray1, subarray2) in zip(array1, array2) {
      averageDifferences.append(subarray1.averageDifference(with: subarray2))
      averageDeviations.append(subarray1.averageDeviation(from: subarray2))
    }

    print("", to: &target)
    print("Average difference for array:\(format(value: averageDifferences.mean))", to: &target)
    print("Average deviation for array:\(format(value: averageDeviations.mean, isPercent: true))",
      to: &target)

  }

}

/// Helper that appends a two column table comparing actual and expected arrays.
///
/// - Parameters:
///   - array1: The first array.
///   - array2: The second array.
///   - target: The output stream to which the text will be written.
private func appendComparison<T>(of array1: [String],
                                 with array2: [String],
                                 target: inout T)
  where T:TextOutputStream
{

  let indexLabel = "Index".padded(to: indexColumnWidth, alignment: .center)
  let actualColumnWidth = max(8, array1.map(\.count).max() ?? 0)
  let actualLabel = "Actual".padded(to: actualColumnWidth, alignment: .center)
  let expectedColumnWidth = max(10, array2.map(\.count).max() ?? 0)
  let expectedLabel = "Expected".padded(to: expectedColumnWidth, alignment: .center)

  print(indexLabel, actualLabel, expectedLabel, separator: "", to: &target)
  print("─" * (indexColumnWidth + actualColumnWidth + expectedColumnWidth), to: &target)

  for (index, (value1, value2)) in zip(array1, array2).enumerated() {

    print(format(index: index),
          "  ",
          value1.padded(to: actualColumnWidth, alignment: .center),
          value2.padded(to: expectedColumnWidth, alignment: .center),
          separator: "",
          to: &target)

  }

  if array1.count > array2.count {

    for (index, value) in zip(array2.count..<array1.count, array1[array2.count...]) {

      print(format(index: index),
            "  ",
            value.padded(to: actualColumnWidth, alignment: .center),
            separator: "",
            to: &target)

    }

  } else if array2.count > array1.count {

    let spacer = " " * actualColumnWidth

    for (index, value) in zip(array1.count..<array2.count, array2[array1.count...]) {

      print(format(index: index),
            "  ",
            spacer,
            value.padded(to: expectedColumnWidth, alignment: .center),
            separator: "",
            to: &target)

    }
    
  }

}

