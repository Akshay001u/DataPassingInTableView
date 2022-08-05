//
//  ViewController.swift
//  DataPassingInTableView
//
//  Created by Akshay on 06/08/22.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var dataTableView: UITableView!
    
    var students : [Student] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        dataTableView?.dataSource = self
        dataTableView?.delegate = self
        navigationItem.title = "Student Data"
        
        dataTableView?.tableFooterView = UIView()
        
        let uiNib = UINib(nibName: "DataTableViewCell", bundle: nil)
        self.dataTableView?.register(uiNib, forCellReuseIdentifier: "customCell")
    }

    @IBAction func addStudentDataBtn(_ sender: Any) {
        let secondViewController = self.storyboard?.instantiateViewController(identifier: "SecondViewController")as? SecondViewController
        secondViewController?.delegateSVC = self
        self.navigationController?.pushViewController(secondViewController!, animated: true)

    }
}

extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        students.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let studentCell = self.dataTableView.dequeueReusableCell(withIdentifier: "customCell", for:indexPath)as! DataTableViewCell
        let eachStudent = students[indexPath.row]
        studentCell.nameLabel.text = eachStudent.studentName
        studentCell.rollNoLabel.text = String(eachStudent.rollNo)
        studentCell.cityLabel.text = eachStudent.city
        studentCell.phoneNoLabel.text = eachStudent.phoneNo
        return studentCell
    }

    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if(editingStyle == .delete)
        {
            dataTableView.beginUpdates()
            students.remove(at: indexPath.row)
            dataTableView.deleteRows(at: [indexPath], with: .fade)
            dataTableView.endUpdates()
        }
    }
    
}



extension ViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
      return 180
    }
}


extension ViewController : StudentDataPassingProtocol {
    func passStudentData(student: Student){
        let student = Student(studentName: student.studentName, rollNo: student.rollNo, city: student.city, phoneNo: student.phoneNo)
        students.append(student)
        dataTableView.reloadData()
    }
}
