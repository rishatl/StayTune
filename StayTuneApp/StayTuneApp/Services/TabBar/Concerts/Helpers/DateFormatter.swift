//
//  DateFormatter.swift
//  CoreDataCRUD
//
//  Copyright © 2016 Jongens van Techniek. All rights reserved.
//

import Foundation

/**
    DateFormatter Utility class
*/
class DateFormatter {

    /**
        Get a NSDate formatted object from a given String.

        - Note: the dateFormat is an optional parameter, with default value: dd-MM-yyyy
        - Parameter dateString: The Date String to parse.
        - Parameter dateFormat: The output format of the NSDate object.
        - Returns: NSDate formatted Date object
    */
    class func getDateFromString(_ dateString: String, dateFormat: String = "yyyy-MM-dd") -> Date {
        let dateFormatter = Foundation.DateFormatter()
        dateFormatter.dateFormat = dateFormat

        return dateFormatter.date(from: dateString)!
    }

    /**
        Get a formatted String from a given NSDate object

        - Note: the dateFormat is an optional parameter, with default value: dd-MM-yyyy
        - Parameter date: The Date object to parse
        - Parameter dateFormat: The output format of the output String
        - Returns: String formatted output date String
    */
    class func getStringFromDate(_ date: Date, dateFormat: String = "yyyy-MM-dd") -> String {
        let dateFormatter = Foundation.DateFormatter()
        dateFormatter.dateFormat = dateFormat

        return dateFormatter.string(from: date)
    }
}
