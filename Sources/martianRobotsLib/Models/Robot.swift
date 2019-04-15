//
//  Robot.swift
//  martianRobotsLib
//
//  Created by Anas Ait Ali on 15/04/2019.
//

import Foundation

struct Robot {
    let position: (x: Int, y: Int, orientation: Orientation)
    let instructions: [String]
}

enum Orientation: String {
    case north = "N"
    case south = "S"
    case east = "E"
    case west = "W"
}
