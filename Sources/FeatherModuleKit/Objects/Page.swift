//
//  File.swift
//
//
//  Created by Tibor Bodecs on 06/03/2024.
//

public struct Page: PageInterface {

    /// Default pagination values.
    public enum Default {

        ///
        /// Default page limit value.
        ///
        /// Default value: 50
        public static var size: UInt = 50

        ///
        /// Default page offset value.
        ///
        /// Default value: 0
        public static var index: UInt = 0
    }

    ///
    /// Limit query value.
    ///
    /// Defaults ot the `Page.Default.size` value if not present
    public let size: UInt

    ///
    /// Offset query value.
    ///
    /// Defaults ot the `Page.Default.index` value if not present
    public let index: UInt

    public init(
        size: UInt? = nil,
        index: UInt? = nil
    ) {
        self.size = size ?? Default.size
        self.index = index ?? Default.index
    }
}
