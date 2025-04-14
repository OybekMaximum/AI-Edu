//
//  PrepareAppViewModel.swift
//  AI&Edu
//
//  Created by Oybek To’laboyev on 13/04/25.
//

import Combine
import Network
import Foundation

protocol PrepareAppViewModelProtocol: AnyObject {
    var isNetworkAvailable: PassthroughSubject<Bool, Never> { get }
    var isLoading: PassthroughSubject<Bool, Never> { get }

    func prepare() async
    func checkInternetConnection()
}

class PrepareAppViewModel: PrepareAppViewModelProtocol {
    let isNetworkAvailable = PassthroughSubject<Bool, Never>()
    let isLoading = PassthroughSubject<Bool, Never>()

    weak var coordinatorDelegate: PrepareAppCoordinatorDelegate?

    deinit {
        coordinatorDelegate?.finish()
    }

    func prepare() async {
        Task { @MainActor in
            let waitingDuration: TimeInterval = 1
            var isAvailable = false

            await withTaskGroup(of: Void.self) { group in
                group.addTask { @MainActor in
                    isAvailable = await NetworkMonitor.isNetworkAvailable(timeout: waitingDuration)
                }

                group.addTask {
                    await self.addTimer(duration: waitingDuration)
                }
            }

            isAvailable ? coordinatorDelegate?.launchApp() : isNetworkAvailable.send(false)
        }
    }

    func checkInternetConnection() {
        Task { @MainActor in

            isLoading.send(true)
            let isAvailable = await NetworkMonitor.isNetworkAvailable(timeout: 2)

            if isAvailable {
                coordinatorDelegate?.launchApp()
            }
            isLoading.send(false)
        }
    }

    private func addTimer(duration: TimeInterval) async {
        await withCheckedContinuation { continuation in
            DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
                continuation.resume()
            }
        }
    }
}

struct NetworkMonitor {
    static func isNetworkAvailable(timeout timeoutInSeconds: TimeInterval) async -> Bool {
        await withCheckedContinuation { continuation in
            let monitor = NWPathMonitor()
            let monitorQueue = DispatchQueue.global(qos: .userInitiated)
            monitor.start(queue: monitorQueue)

            let isCompleted = Flag()

            monitor.pathUpdateHandler = { path in
                monitorQueue.async(flags: .barrier) {
                    if !isCompleted.value, path.status == .satisfied {
                        isCompleted.value = true
                        monitor.cancel()
                        continuation.resume(returning: true)
                    }
                }
            }

            monitorQueue.asyncAfter(deadline: .now() + timeoutInSeconds, flags: .barrier) {
                if !isCompleted.value {
                    isCompleted.value = true
                    monitor.cancel()
                    continuation.resume(returning: false)
                }
            }
        }
    }
}

private class Flag {
    private let queue = DispatchQueue(
        label: "flag.queue",
        attributes: .concurrent
    )

    private var _value: Bool = false

    var value: Bool {
        get {
            queue.sync {
                _value
            }
        }
        set {
            queue.async(flags: .barrier) {
                self._value = newValue
            }
        }
    }
}
