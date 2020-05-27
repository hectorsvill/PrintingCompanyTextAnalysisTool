//
//  Cache.swift
//  PrintingCompanyTextAnalysisTool
//
//  Created by Hector S. Villasano on 5/26/20.
//  Copyright © 2020 Hector Steven  Villasano. All rights reserved.
//

import Foundation

class Cache <Key: Hashable, Value> {
    let queue = DispatchQueue(label: "com.hectorstevenvillasano.PrintingCompanyTextAnalysisTool.CacheDispatchQueue")
    private var cache: [Key: Value] = [:]

    func cache(value: Value, for key: Key) {
        queue.sync {
            if let _ = cache[key] { return }
            cache[key] = value
        }
    }

    func value(for key: Key) -> Value? {
        return queue.sync { cache[key] }
    }
}
