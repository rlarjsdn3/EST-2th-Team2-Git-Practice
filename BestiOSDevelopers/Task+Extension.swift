//
//  Task+Extension.swift
//  BestiOSDevelopers
//
//  Created by 김건우 on 5/8/25.
//

import Foundation

extension Task where Failure == Error {

    static func delayed(
        byInterval interval: TimeInterval,
        priority: TaskPriority? = nil,
        operation: @Sendable @escaping @isolated(any) () async -> Success
    ) {
        Task<Success, Failure>(priority: priority) {
            let interval = UInt64(interval * 1_000_000_000)
            try await Task<Never, Never>.sleep(nanoseconds: interval)
            return await operation()
        }
    }
}
