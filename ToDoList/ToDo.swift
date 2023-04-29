//
//  ToDo.swift
//  ToDoList
//
//  Created by Антон Адамсон on 29.04.2023.
//

import UIKit

struct ToDo: Equatable {
    let id = UUID()
    var title: String
    var isComplete: Bool
    var dueDate: Date
    var notes: String?
    
    static func ==(lhs: ToDo, rhs: ToDo) -> Bool {
        return lhs.id == rhs.id
    }
    
    // Статический метод, который извлекает массив элементов, хранимых на диске, если они есть, и возвращает их. На данный момент заполнен возврат nil
    static func loadToDos() -> [ToDo]? {
        return nil
    }
    
    // Статический метод, который заполнит массив примерными данными.
    static func loadSampleToDos() -> [ToDo] {
        let toDo1 = ToDo(title: "To-Do One", isComplete: false, dueDate: Date(), notes: "Note 1")
        let toDo2 = ToDo(title: "To-Do Two", isComplete: false, dueDate: Date(), notes: "Note 2")
        let toDo3 = ToDo(title: "To-Do Three", isComplete: false, dueDate: Date(), notes: "Note 3")
        
        return [toDo1, toDo2, toDo3]
    }
}
