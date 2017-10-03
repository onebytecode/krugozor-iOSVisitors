//
//  TaskPull.swift
//  krugozor-visitorsApp
//
//  Created by Анатолий on 28.09.2017.
//  Copyright © 2017 oneByteCode. All rights reserved.
//

import Foundation

/// Accounting of active asynchronous tasks
class TaskPool {

    static let instance = TaskPool() // singleton

    let session = URLSession.shared // default session
    let baseURLString = "https://myserver.com/api/v1/" // default base URL
    var defaultHeaders: [String: String] { // default headers list
        return ["Content-Type": "application/json"]
    }

    private(set) var activeTasks = Set<DataTask>()

    // MARK: - Root

    private init() { } // forbid multi-instantiation

    // MARK: - Controls

    func send(task: DataTask, callback: DataTaskCallback?) {
        // check for existing task
        if taskById(task.taskId) != nil {
            print("task with id \"\(task.taskId)\" is already active.")
            return
        }
        // start
        activeTasks.insert(task)
        print("start task \"\(task.taskId)\". URL: \(task.request.url!.absoluteString)")

        task.start { [unowned self] (task) in
            self.activeTasks.remove(task)
            print("task finished \"\(task.taskId)\". URL: \(task.request.url!.absoluteString)")
            callback?(task)
        }
    }

    func send(taskId: String, request: URLRequest, callback: DataTaskCallback?) {
        let task = DataTask(taskId: taskId, request: request, session: session)
        send(task: task, callback: callback)
    }

    func taskById(_ taskId: String) -> DataTask? {
        return activeTasks.first(where: { (task) -> Bool in
            return task.taskId == taskId
        })
    }
}
