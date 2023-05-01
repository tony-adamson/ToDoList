//
//  ToDoTableViewController.swift
//  ToDoList
//
//  Created by Антон Адамсон on 29.04.2023.
//

import UIKit

class ToDoTableViewController: UITableViewController {

    // Определяем переменную как массив списка дел
    var toDos = [ToDo]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Проверка наличия сохраненных данных при первом запуске приложения, если их нет, подгрузить пример
        if let savedToDos = ToDo.loadToDos() {
            toDos = savedToDos
        } else {
            toDos = ToDo.loadSampleToDos()
        }
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Раскомментированный шаблон для создания кнопки в баре
        self.navigationItem.leftBarButtonItem = self.editButtonItem
    }
    
    // Метод для редактирования выбранной ячейки из общего списка. получен протягиванием связи между нави и тудутейблвьюконтроллер
    @IBSegueAction func editToDo(_ coder: NSCoder, sender: Any?) -> ToDoDetailTableViewController? {
        let detailController = ToDoDetailTableViewController(coder: coder)
        
        guard let cell = sender as? UITableViewCell, let indexPath = tableView.indexPath(for: cell) else {
            // if sender is the add button, return an empty controller
            return detailController
        }
        tableView.deselectRow(at: indexPath, animated: true)
        detailController?.toDo = toDos[indexPath.row]
        
        return detailController
    }
    
    
    // MARK: - Table view data source

    // Настраиваем количество ячеек, оно будет равно количесву элемен во в массиве toDos
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return toDos.count
    }

    // Конфигурируем ячейки, в ячейке будет отобрадаться только заголовок
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoCellIdentifier", for: indexPath)

        let toDo = toDos[indexPath.row]
        var content = cell.defaultContentConfiguration()
        content.text = toDo.title
        cell.contentConfiguration = content
        
        return cell
    }

    // Override to support conditional editing of the table view.
    // Активируем функциональность для удаления ячейки по свайпу
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        // Проверяем, что метод вызван именно кнопкой Delete
        if editingStyle == .delete {
            // Delete the row from the data source
            toDos.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }


    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    // MARK: - Navigation

    // Метод для ввода подготовленных данных и проверка, обновить существующие данные или создать новую ячейку
    @IBAction func unwindToToDoList(segue: UIStoryboardSegue) {
        guard segue.identifier == "saveUnwind" else { return }
        
        let sourceViewController = segue.source as! ToDoDetailTableViewController
        
        if let toDo = sourceViewController.toDo {
            if let indexOfExistingToDo = toDos.firstIndex(of: toDo) {
                toDos[indexOfExistingToDo] = toDo
                tableView.reloadRows(at: [IndexPath(row: indexOfExistingToDo, section: 0)], with: .automatic)
            } else {
                let newIndexPath = IndexPath(row: toDos.count, section: 0)
                toDos.append(toDo)
                tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
        }
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    //override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    //}

}
