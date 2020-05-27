//
//  ConcurrentOperation.swift
//  PrintingCompanyTextAnalysisTool
//
//  Created by Hector S. Villasano on 5/26/20.
//  Copyright © 2020 Hector Steven  Villasano. All rights reserved.
//

import Foundation
class ConcurrentOperation: Operation {
    private let stateQueue = DispatchQueue(label: "com.hectorstevenvillasano.PrintingCompanyTextAnalysisTool.ConcurrentOperation")

    enum State: String {
        case isReady, isExecuting, isFinished
    }

    private var _state = State.isReady

    var state: State {
        get {
            var result: State?
            let queue = self.stateQueue

            queue.sync {
                result = _state
            }

            return result!
        }

        set {
            let oldValue = state
            willChangeValue(forKey: newValue.rawValue)
            willChangeValue(forKey: oldValue.rawValue)

            stateQueue.sync {
                self._state = newValue
            }

            didChangeValue(forKey: oldValue.rawValue)
            didChangeValue(forKey: newValue.rawValue)
        }
    }
}

extension ConcurrentOperation {
    override dynamic var isReady: Bool {
        super.isReady && state == .isReady
    }

    override dynamic var isExecuting: Bool {
        state == .isExecuting
    }

    override dynamic var isFinished: Bool {
        state == .isFinished
    }

    override var isAsynchronous: Bool {
        true
    }
}
