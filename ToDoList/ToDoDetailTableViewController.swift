//
//  ToDoDetailTableViewController.swift
//  ToDoList
//
//  Created by Антон Адамсон on 30.04.2023.
//

import UIKit

class ToDoDetailTableViewController: UITableViewController {

    //MARK: - IBOutlets
    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var isCompleteButton: UIButton!
    @IBOutlet var dueDateLabel: UILabel!
    @IBOutlet var dueDateDatePicker: UIDatePicker!
    @IBOutlet var notesTextView: UITextView!
    @IBOutlet var saveButton: UIBarButtonItem!
    
    //MARK: - Additional variables
    // Свойства для для управления скрытием ячейки с дейтпикером
    var isDatePickerHidden = true
    let dateLabelIndexPath = IndexPath(row: 0, section: 1)
    let datePickerIndexPath = IndexPath(row: 1, section: 1)
    let notesIndexPath = IndexPath(row: 0, section: 2)
    
    var toDo: ToDo?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updateSaveButtonState()
        // Установим значение даты + 24 часа к текущей в секундах
        dueDateDatePicker.date = Date().addingTimeInterval(24*60*60)
        updateDueDateLabel(date: dueDateDatePicker.date)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    
    @IBAction func textEditingChanged(_ sender: UITextField) {
        updateSaveButtonState()
    }
    
    // Метод скрывает клавиатуру при нажатии ввода на клавиатуре внутри текстового поля
    @IBAction func returnPressed(_ sender: UITextField) {
        sender.resignFirstResponder()
    }
    
    // Метод срабатывает по нажатию на кнопку с иконкой завершения и меняет ее изображение
    @IBAction func isCompleteButtonTapped(_ sender: UIButton) {
        isCompleteButton.isSelected.toggle()
    }
    
    // Метод срабатывает при измении даты в пикере
    @IBAction func dataPickerChanged(_ sender: UIDatePicker) {
        updateDueDateLabel(date: sender.date)
    }
    
    //MARK: - Helpers methods
    // Метод для деактивации кнопки при незаполненном текстовом поле
    func updateSaveButtonState() {
        let shouldEnableSaveButton = titleTextField.text?.isEmpty == false
        saveButton.isEnabled = shouldEnableSaveButton
    }
    
    // Метод для обновления даты на метке
    func updateDueDateLabel(date: Date) {
        dueDateLabel.text = date.formatted(.dateTime.month(.defaultDigits).day().year(.twoDigits).hour().minute())
    }
    
    // Метод управления высотой ячейки дейт пикера
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath {
            case datePickerIndexPath where isDatePickerHidden == true:
                return 0
            case notesIndexPath:
                return 200
            default:
                return UITableView.automaticDimension
            }
    }
    
    // Метод управления высотой других ячеек таблицы
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath {
            case datePickerIndexPath:
                return 216
            case notesIndexPath:
                return 200
            default:
                return UITableView.automaticDimension
            }
    }
    
    // метод срабатывает при выборе ячейки с датой
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
            if indexPath == dateLabelIndexPath {
                isDatePickerHidden.toggle()
                updateDueDateLabel(date: dueDateDatePicker.date)
                tableView.beginUpdates()
                tableView.endUpdates()
            }
    }
    
    /*
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }
     */
     
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    // Подготовка данных для передачи в другой вьюконтроллер
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        //если идентификатор перехода нужный, то идем дальше
        guard segue.identifier == "saveUnwind" else { return }
        let title = titleTextField.text!
        let isComplete = isCompleteButton.isSelected
        let dueDate = dueDateDatePicker.date
        let notes = notesTextView.text
        
        let toDo = ToDo(title: title, isComplete: isComplete, dueDate: dueDate,notes: notes)
    }


}
