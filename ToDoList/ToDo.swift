//
//  ToDo.swift
//  ToDoList
//
//  Created by Антон Адамсон on 29.04.2023.
//

import UIKit

// Добавляем соответствие протоколу Codable чтобы реализовать возможность сохранения данных приложения
struct ToDo: Equatable, Codable {
    // Меняем id = на : и прописываем инициализатор
    let id: UUID
    var title: String
    var isComplete: Bool
    var dueDate: Date
    var notes: String?
    
    // Инициализатор для id
    init(title: String, isComplete: Bool, dueDate: Date, notes: String?) {
        self.id = UUID()
        self.title = title
        self.isComplete = isComplete
        self.dueDate = dueDate
        self.notes = notes
    }
    
    // Мы хотим сохранить наши данные где-то в директории "Документы" моего приложения. Поскольку эта директория доступна моему приложению и не может быть изменена другим приложением, это безопасное место для хранения моего списка. Мы используем класс FileManager, чтобы найти директорию Документов моего приложения, создадим подпапку для архивации данных и сохраним этот путь в константу. Чтобы убедиться, что константы определяются только один раз и не связаны с конкретным экземпляром модели, используем ключевое слово static. Добавим следующие определения констант в свою модель, убедившись, что ArchiveURL определен с соответствующей строкой подпапки:
    static let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    static let archiveURL = documentsDirectory.appendingPathComponent("toDos").appendingPathExtension("plist")
    
    static func ==(lhs: ToDo, rhs: ToDo) -> Bool {
        return lhs.id == rhs.id
    }
    
    // Статический метод, который извлекает массив элементов, хранимых на диске, если они есть, и возвращает их. На данный момент заполнен возврат nil, далее изменена на логику для загрузки данных с диска
    static func loadToDos() -> [ToDo]? {
        guard let codedToDos = try? Data(contentsOf: archiveURL) else { return nil }
        let propertyListDecoder = PropertyListDecoder()
        return try? propertyListDecoder.decode(Array<ToDo>.self, from: codedToDos)
    }
    
    // Перед тем, как попытаться прочитать модельные данные с диска, необходимо предоставить способ сохранения их на диск. Напишем статический метод, который использует PropertyListEncoder для кодирования коллекции [ToDo], а затем использует метод write(to:options:) на Data для хранения ее в каталоге Documents:
    static func saveToDos(_ toDos: [ToDo]) {
        let propertyListEncoder = PropertyListEncoder()
        let codedToDos = try? propertyListEncoder.encode(toDos)
        try? codedToDos?.write(to: archiveURL, options: .noFileProtection)
    }
    
    // Статический метод, который заполнит массив примерными данными.
    static func loadSampleToDos() -> [ToDo] {
        let toDo1 = ToDo(title: "To-Do One", isComplete: false, dueDate: Date(), notes: "Note 1")
        let toDo2 = ToDo(title: "To-Do Two", isComplete: false, dueDate: Date(), notes: "Note 2")
        let toDo3 = ToDo(title: "To-Do Three", isComplete: false, dueDate: Date(), notes: "Note 3")
        
        return [toDo1, toDo2, toDo3]
    }
}
