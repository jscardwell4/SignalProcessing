//
//  DataChunk.swift
//  caf_info
//
//  Created by Jason Cardwell on 12/20/17.
//  Copyright © 2017 Moondeer Studios. All rights reserved.
//
import Foundation

extension CAFFile {

  public struct DataChunkData: CAFFileChunkData {

    public let size: Int

    public init(size: Int) { self.size = size }

    public init?(data: Data) { size = data.count }

    public var description: String { return "DataChunk { size: \(size) bytes }" }

  }

}
