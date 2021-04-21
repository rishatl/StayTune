//
//  EntityTypes.swift
//  StayTuneApp
//
//  Created by Rishat on 09.04.2021.
//

import Foundation

/**
    Enum for holding different entity type names (Coredata Models)
*/
enum EntityTypes: String {
    case Event = "Event"
    //case Foo = "Foo"
    //case Bar = "Bar"

    static let getAll = [Event] //[Event, Foo,Bar]
}
