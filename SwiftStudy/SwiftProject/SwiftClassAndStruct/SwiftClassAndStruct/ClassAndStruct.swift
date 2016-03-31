//
//  ClassAndStruct.swift
//  SwiftClassAndStruct
//
//  Created by lz on 16/3/31.
//

import Foundation

class SomeClass {
    lazy var name: String = {
        let name = "Class"
        return name
    }()
    
}

struct SomeStructure {
    lazy var name: String = {
        let name = "Struct"
        return name
    }()
    var age = "19"
}

private enum LazyValue<T> {
    case NotYetComputed(() -> T)
    case Computed(T)
}


final class LazyBox<T> {
    init(computation: () -> T) {
        _value = .NotYetComputed(computation)
    }
    
    private var _value: LazyValue<T>
    
    var value: T {
        switch self._value {
        case .NotYetComputed(let computation):
            let result = computation()
            self._value = .Computed(result)
            return result
        case .Computed(let result):
            return result
        }
    }
}