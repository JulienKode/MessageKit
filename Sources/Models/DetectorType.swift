/*
 MIT License

 Copyright (c) 2017-2018 MessageKit

 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:

 The above copyright notice and this permission notice shall be included in all
 copies or substantial portions of the Software.

 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 SOFTWARE.
 */

import Foundation

public enum DetectorType: Hashable {

    case address
    case date
    case phoneNumber
    case url
    case transitInformation
    case custom(regex: NSRegularExpression)

    // swiftlint:disable force_try
    public static let hashtag = DetectorType.custom(regex: try! NSRegularExpression(pattern: "/#\\w+(.)\\w+/igm", options: []))
    public static let mention = DetectorType.custom(regex: try! NSRegularExpression(pattern: "/@\\w+(.)\\w+/igm", options: []))

    internal var textCheckingType: NSTextCheckingResult.CheckingType {
        switch self {
        case .address: return .address
        case .date: return .date
        case .phoneNumber: return .phoneNumber
        case .url: return .link
        case .transitInformation: return .transitInformation
        case .custom: return .regularExpression
        }
    }

    ///The hashValue of the `DetectorType` so we can conform to `Hashable` and be sorted.
    public var hashValue: Int {
        return self.toInt()
    }

    /// Return an 'Int' value for each `DetectorType` type so `DetectorType` can conform to `Hashable`
    private func toInt() -> Int {
        switch self {
        case .address:
            return 0
        case .date:
            return 1
        case .phoneNumber:
            return 2
        case .url:
            return 3
        case .transitInformation:
            return 4
        case .custom(let regex):
            return regex.hashValue
        }
    }

}
