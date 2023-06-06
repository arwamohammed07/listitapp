//
//  NewTask.swift
//  listit!!
//
//  Created by Arwamohammed07 on 08/08/1444 AH.
//

import SwiftUI
import UserNotifications


struct NewTask: View {
    @Environment(\.dismiss) var dismiss
    
    func scheduleNotification() {
            let content = UNMutableNotificationContent()
            content.title = "Task Reminder"
            content.body = taskDescription
            content.sound = UNNotificationSound.default
            
            let triggerDate = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: taskDate)
            let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: false)
            
            let request = UNNotificationRequest(identifier: "TaskReminder", content: content, trigger: trigger)
            
            UNUserNotificationCenter.current().add(request) { (error) in
                if let error = error {
                    print("Error scheduling notification: \(error)")
                }
            }
        }
    
    // MARK: - Task Values
    @State var taskTitle: String = ""
    @State var taskDescription: String = ""
    @State var taskDate: Date = Date()
    
    // MARK: - Core data context
    @Environment(\.managedObjectContext) var context
    
    @EnvironmentObject var taskModel : TaskViewModel
    var body: some View {
        NavigationView{
            List{
                Section{
                   TextField("Add New Task", text: $taskTitle)
                } header: {
                    Text("New Task")
                }
                Section{
                   TextField("Add Description", text: $taskDescription)
                       
                } header: {
                    Text("Description")
                }
                // MARK: -  disabling data for edit mode
                if taskModel.editTask == nil {
                    Section{
                                    DatePicker("", selection: $taskDate)
                            .datePickerStyle(.graphical)
                                         .labelsHidden()
                                 } header: {
                                     Text("Date")
                                 }
                }
//                Section{
//                   DatePicker("", selection: $taskDate)
//                        .datePickerStyle(.graphical)
//                        .labelsHidden()
//                } header: {
//                    Text("Date")
//                }
                
                
                
            }
            .listStyle(.insetGrouped)
            .navigationTitle("Add Task")
            .navigationBarTitleDisplayMode(.inline)
            // MARK: -  disballing dismiss on swip
            .interactiveDismissDisabled()
            // MARK: - Action Button
            .toolbar{
          ToolbarItem(placement: .navigationBarTrailing){
              Button("Save"){
                 
                  if let task = taskModel.editTask{
                      
                      task.taskTitle = taskTitle
                      task.taskDescription = taskDescription
                  //    task.taskDate = taskDate

                  }
                  else{
                      let task = Lola(context: context)
                      task.taskTitle = taskTitle
                      task.taskDescription = taskDescription
                      task.taskDate = taskDate
                  } 
                  
                  // MARK: - saving
                  try? context.save()
                  scheduleNotification()
                  // MARK: - dismiss view
                  dismiss()
                  scheduleNotification()
              }
              .disabled(taskTitle == "" || taskDescription == "")
                }
                ToolbarItem(placement: .navigationBarLeading){
                    Button("Cancel"){
                        dismiss()
                    }
                      }
            }
            // MARK: - loding Task date if from edit
            .onAppear{
                if let task = taskModel.editTask{
        taskTitle = task.taskTitle ?? ""
        taskDescription = task.taskDescription ?? ""
                }
            }
        }
    }
}
