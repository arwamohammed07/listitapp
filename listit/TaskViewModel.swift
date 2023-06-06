//
//  TaskViewModel.swift
//  listit1
//
//  Created by Arwamohammed07 on 02/08/1444 AH.
//

import SwiftUI

class TaskViewModel: ObservableObject{
//    // MARK: - simple task
//    @Published var storedTask: [Task] = [
//        Task(taskTitle: "Hi", taskDescription: "Hello", taskDate: .init(timeIntervalSince1970: 1677580861)),
//        Task(taskTitle: "arwa", taskDescription: "Mohammed", taskDate: .init(timeIntervalSince1970: 1677580861)),
//        Task(taskTitle: "lolo", taskDescription: "turkey", taskDate: .init(timeIntervalSince1970: 1677580861))
//
//    ]
    // MARK: -  Currnet Week Days
    @Published var currentWeek : [Date] = []
    // MARK: -  Checking if current day is Today
    @Published var currentDay : Date = Date()
    // MARK: -  Filtering today task
    @Published var filteredTasks : [Lola]?
    // MARK: - New Task View
    @Published var AddNewTask: Bool = false
    // MARK: - Edit Data
    @Published var editTask : Lola?
    
    
    // MARK: - Intializing
    init(){
        fetchCurrentWeek()
       // filterTodayTasks()
    }
    
    // MARK: - Filtering today task
//    func filterTodayTasks(){
//        DispatchQueue.global(qos: .userInteractive).async {
//            let calendar = Calendar.current
//            let filtered = self.storedTask.filter {
//                return calendar.isDate($0.taskDate, inSameDayAs: self.currentDay)
//            }
//            DispatchQueue.main.async {
//                withAnimation{
//                    self.filteredTasks = filtered
//                }
//            }
//        }
//    }
    // MARK: -
    func fetchCurrentWeek(){
        let today = Date()
        let calender = Calendar.current
        
        let week = calender.dateInterval(of: .weekOfMonth, for: today)
        guard let firstWeekDay = week?.start else{
            return
        }
        (0...20).forEach{ day in
            if let weekday = calender.date(byAdding: .day, value: day, to: firstWeekDay){
                currentWeek.append(weekday)
            }
            
        }
    }
    // MARK: -Extracting Date
    // MARK: -  func extractDate(date: Date,format: String){
        func extractDate(date: Date, format: String)->String{
            let formatter = DateFormatter()

            formatter.dateFormat = format
     
            return formatter.string(from: date)
    }
    // MARK: - Checking if current day is Today
    func isToday(date: Date)->Bool{
        let calender = Calendar.current
        return calender.isDate(currentDay, inSameDayAs: date)
    }
    
    // MARK: - Checking if the currentHour is task Hour
    func isCurrentHour(date: Date)->Bool{
        let calender = Calendar.current
        let hour = calender.component(.hour, from: date)
        let currentHour = calender.component(.hour, from: Date())
        // MARK: -
        let isToday = calender.isDateInToday(date)
        return (hour == currentHour && isToday)
      //  return hour == currentHour
    }
    
}
