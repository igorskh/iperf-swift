# Swift wrapper for iPerf

An appliction using this package: [iPerf SwiftUI](https://github.com/igorskh/iperf-swiftui)

Package implements iPerf server and client.

Usage example:
```swift
class IperfRunnerController: ObservableObject, Identifiable {
    private var iperfRunner: IperfRunner?
    
    @Published var isDeleted = false
    @Published var runnerState: IperfRunnerState = .ready
    @Published var debugDescription: String = ""
    @Published var displayError: Bool = false
    @Published var results = [IperfIntervalResult]() {
        didSet {
            objectWillChange.send()
        }
    }
    
    func onResultReceived(result: IperfIntervalResult) {
        if result.streams.count > 0 {
            results.append(result)
        }
    }
    
    func onErrorReceived(error: IperfError) {
        DispatchQueue.main.async {
            self.displayError = error != .IENONE
            self.debugDescription = error.debugDescription
        }
    }
    
    func onNewState(state: IperfRunnerState) {
        if state != .unknown && state != runnerState {
            DispatchQueue.main.async {
                self.runnerState = state
            }
        }
    }
    
    func start() {
        self.formInput = formInput
        
        results = []
        debugDescription = ""
        
        iperfRunner = IperfRunner(with: IperfConfiguration())
        iperfRunner!.start(
            onResultReceived,
            onErrorReceived,
            onNewState
        )
    }
    
    func stop() {
        iperfRunner!.stop()
    }
}

```
