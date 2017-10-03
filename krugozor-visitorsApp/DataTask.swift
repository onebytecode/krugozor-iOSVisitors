//
//  DataTask.swift
//  krugozor-visitorsApp
//
//  Created by Анатолий on 28.09.2017.
//  Copyright © 2017 oneByteCode. All rights reserved.
//

import Foundation

typealias DataTaskCallback = (DataTask) -> Void

/// Storing of all data, all received data and its state (completed / canceled),
/// It also manages to send itself to the network and call the callback after the completion of the work. When receiving a response from the server, it writes all the received data, including attempts to transform the input data into the JSON object, if possible, to simplify the subsequent processing.
final class DataTask: Hashable, Equatable {

    /// ID of task in query
    let taskId: String
    let request: URLRequest
    let session: URLSession

    private(set) var responseObject: Response?
    private(set) var response: URLResponse?
    private(set) var error: Error?
    private(set) var isCancelled = false
    private(set) var isCompleted = false

    private var task: URLSessionDataTask?

    // MARK: - Root

    init(taskId: String, request: URLRequest, session: URLSession = URLSession.shared) {
        self.taskId = taskId
        self.request = request
        self.session = session
    }

    // MARK: - Controls

    /// Srart url request
    func start(callback: DataTaskCallback?) {
        task = session.dataTask(with: request) { [unowned self] (data, _, error) in
            if self.isCancelled {
                return
            }
            self.isCompleted = true
            // transform if possible
            var wrappedData: Any? = data

            if data != nil {
                if let json = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) {
                    wrappedData = json
                }
            }
            // parse
            self.responseObject = Response(json: wrappedData)
            self.error = error
            // callback
            callback?(self)
        }
        task?.resume()
    }

    func cancel(callback: DataTaskCallback?) {
        if task != nil && !isCompleted && !isCancelled {
            isCancelled = true
            task?.cancel()
            // callback
            callback?(self)
        }
    }

    // MARK: - Equatable

    static func ==(lhs: DataTask, rhs: DataTask) -> Bool {
        return lhs.taskId == rhs.taskId
    }

    // MARK: - Hashable

    var hashValue: Int {
        return taskId.hashValue
    }
}
