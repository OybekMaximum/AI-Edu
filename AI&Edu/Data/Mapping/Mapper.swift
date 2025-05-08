//
//  Mapper.swift
//  AI&Edu
//
//  Created by Oybek To’laboyev on 08/05/25.
//

import Foundation

protocol Mapper {
    associatedtype Source
    associatedtype Destination

    func map(_ source: Source) -> Destination
}

struct ListMapper<Source, Destination, ItemMapper: Mapper>: Mapper
where Source == ItemMapper.Source, Destination == ItemMapper.Destination {
    let itemMapper: ItemMapper

    func map(_ source: [Source]) -> [Destination] {
        source.map { itemMapper.map($0) }
    }
}

struct ListCompactMapper<Source, Destination, ItemMapper: Mapper>: Mapper
where Source == ItemMapper.Source, Destination? == ItemMapper.Destination {

    let itemMapper: ItemMapper

    func map(_ source: [Source]) -> [Destination] {
        source.compactMap { itemMapper.map($0) }
    }
}
