//
//  Home.swift
//  listit1
//
//  Created by Arwamohammed07 on 02/08/1444 AH.
//

import SwiftUI
import UserNotifications


struct Home: View {
    
    
//    func scheduleNotification() {
//            let content = UNMutableNotificationContent()
//            content.title = "Task Reminder"
//            content.body = taskDescription
//            content.sound = UNNotificationSound.default
//            
//            let triggerDate = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: taskDate)
//            let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: false)
//            
//            let request = UNNotificationRequest(identifier: "TaskReminder", content: content, trigger: trigger)
//            
//            UNUserNotificationCenter.current().add(request) { (error) in
//                if let error = error {
//                    print("Error scheduling notification: \(error)")
//                }
//            }
//        }
//    
//    @State var taskTitle: String = ""
//    @State var taskDescription: String = ""
//    @State var taskDate: Date = Date()
//    
  
    @StateObject var taskModel: TaskViewModel = TaskViewModel()
    @Namespace var animation
    
    //Core data context
    @Environment(\.managedObjectContext) var context
    //Edit button context
    @Environment(\.editMode) var editButton

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            //Lazy stack with header
            LazyVStack(spacing: 15, pinnedViews: [.sectionHeaders]) {
                Section{
                   //Current Week View
                    ScrollView(.horizontal, showsIndicators: false){
                        HStack(spacing: 10){
                            ForEach(taskModel.currentWeek,id: \.self){ day in
//                                Text(day.formatted(date: .abbreviated, time: .omitted))
                                VStack(spacing: 10){
                                    //EEE will retun Day as Mon Tue Sat
                                    Text(taskModel.extractDate(date: day, format: "dd"))
                                        .font(.system(size: 15))
                                        .fontWeight(.semibold)
                                    //EEE will retun Day as Mon Tue Sat
                                    Text(taskModel.extractDate(date: day, format: "EEE"))
                                        .font(.system(size: 14))
                                        .fontWeight(.semibold)
                                    
                                    Circle()
                                        .fill(.white)
                      .frame(width: 8, height: 8)
                      .opacity(taskModel.isToday(date: day) ? 1: 0)
                                       
                                }
                 // Forground style
                                .foregroundStyle(taskModel.isToday(date: day) ? .primary : .secondary)                                .foregroundColor(taskModel.isToday(date: day) ? .white : .black)
                                //Capcel Shape
                                .frame(width: 45, height: 90)
                                .background(
                                    ZStack{
                //Matched  Effect
//                                        Capsule()
//                                         .fill(Color.accentColor)
                                           
                                        if taskModel.isToday(date: day){
                                            Capsule()
                                                .fill(Color.accentColor)
                                                .matchedGeometryEffect(id: "CURRENTDAY", in: animation)
                                        }
                                    }
                                )
                                .contentShape(Capsule())
                                .onTapGesture {
                                    withAnimation{
                                        taskModel.currentDay = day
                                    }
                                }

                            }
                        }
                        
                        .padding(.horizontal)
                    }
                    TaskView()
                } header: {
                    HeaderView()
                }
                
            }
        }
        
        .ignoresSafeArea(.container, edges: .top)
        
        //MARK: - Add Button
        .overlay(
            Button(action: {
                taskModel.AddNewTask.toggle()
            }, label: {
                Image(systemName: "plus")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.accentColor,in: Circle())
            })
            .padding()
            ,alignment: .bottomTrailing
        )
        
//        .sheet(isPresented: $taskModel.AddNewTask){
//            NewTask()
        .sheet(isPresented: $taskModel.AddNewTask ) {
            //MARK: - clering edit data
            taskModel.editTask = nil
        }
    content: {
        NewTask()
            .environmentObject(taskModel)
        }
        
   }
    //MARK: - Task View
    func TaskView()->some View{
        LazyVStack(spacing: 18){
            // MARK: - Converting object as our task Model
            DynamicFilteredView(dateToFilter: taskModel.currentDay) { (object : Lola) in
                TaskCardView(task: object)
                
            }
//        if let tasks = taskModel.filteredTasks{
//            if tasks.isEmpty{
////                Text("No Tasks Here!!")
////                    .foregroundColor(.secondary)
////                    .font(.system(size: 16))
////                    .fontWeight(.light)
////                    .offset(y:100)
//            }
//            else{
//                ForEach(tasks){ task in
//                    TaskCardView(task: task)
//                }
//            }
//            }
//            else{
//               // MARK: - prograss view
//                ProgressView()
//                    .offset(y:10)
//            }
        }
        .padding()
        .padding(.top)
        
        // MARK: - Updaitng tasks
//        .onChange(of: taskModel.currentDay){ newValue in
//            taskModel.filterTodayTasks()
//
//        }
    }
    //MARK: - Task Card View
    func TaskCardView(task: Lola)->some View{
        HStack(alignment: editButton?.wrappedValue == .active ? .center : .top, spacing: 30){
           
          
            //MARK: - if edit mode enabled then showing delete Button
            if editButton?.wrappedValue == .active{
                // MARK: - Edit button for current and future taks
                VStack(spacing: 12){
                    
                    //MARK: - if (task.taskDate ?? Date()) >= Date(){
                    if task.taskDate?.compare(Date()) == .orderedDescending || taskModel.isToday(date: task.taskDate ?? Date()) {
                    
                        Button {
                            taskModel.editTask = task
                            taskModel.AddNewTask.toggle()
                            
                       
                                       } label: {
                                           Image(systemName: "pencil.circle.fill")
                                               .font(.title)
                                               .foregroundColor(.primary)
                                            //   .accessibility(label: Text("تعديل"))
                                       }
                    }
                    Button {
                 //MARK: - deleting task
                                       context.delete(task)
                  //MARK: - saving
                                       try? context.save()
                   
                                   } label: {
                                       Image(systemName: "minus.circle.fill")
                                           .font(.title)
                                           .foregroundColor(.red)
                                        //   .accessibility(label: Text("حذف"))
                                   }
                }


            }
            else{
//                VStack(spacing: 10){
////                  //  Circle()
////                        .fill(taskModel.isCurrentHour(date: task.taskDate ?? Date()) ? (task.isCompleted ? .green : .black) : .clear)
//                  //      .frame(width: 15,height: 15)
////                        .background(
////                            Circle()
////                                .stroke(.black,lineWidth: 1)
////                                .padding(-3)
//                        //)
//
//                 //       .scaleEffect(taskModel.isCurrentHour(date: task.taskDate ?? Date()) ? 0.8 : 1 )
//
////                    Rectangle()
////                        .fill(.black)
////                        .frame(width: 3)
//                }
            }
            ZStack{
               
                VStack{
                    HStack(alignment: .top, spacing: 10){
                        VStack(alignment: .leading, spacing: 12){
                            Text(task.taskTitle ?? "")
                                .font(.title2.bold())
                                .foregroundColor(.primary)
                            
                            Text(task.taskDescription ?? "")
                                .font(.callout)
                                .foregroundColor(.secondary)
                            
                        }
                        
                        .hLeading()
                        
                  Text(task.taskDate?.formatted(date: .omitted, time: .shortened) ?? "" )
                            .foregroundColor(.secondary)
                        
                    }
                    
                    
                    
                    if taskModel.isCurrentHour(date: task.taskDate ?? Date()){
                        // MARK: - Team Members
                        HStack(spacing:0){
                            //                        HStack(spacing:-10){
                            //                            ForEach(["profile","profile"],id: \.self){ user in
                            //                                Image(user)
                            //                                    .resizable()
                            //                                    .aspectRatio( contentMode: .fill)
                            //                                    .frame(width: 44,height: 44)
                            //                                    .clipShape(Circle())
                            //                                    .background(
                            //                                        Circle()
                            //                                            .stroke(.black,lineWidth: 1)
                            //                                    )
                            //
                            //                            }
                            //                        }
                            
                            //.hLeading()
                            
                            // MARK: - Check Button
                            if !task.isCompleted{
                                Button{
                                    
                                    // MARK: - Updating  task
                                    
                                    task.taskCompleted = true
                                    
                                    // MARK: - saving
                                    try? context.save()
                                    
                                } label: {
                                    //                                Image(systemName: "checkmark")
                                    //                                    .foregroundColor(.black)
                                    //                                    .padding(10)
                                    //                                    .background(Color.white,in: RoundedRectangle(cornerRadius: 10))
                                }
                                
                            }
                            
                            //                        Text(task.isCompleted ? "Marked as completed" : "Mark Task as Completed" )
                            //                            .font(.system(size: task.isCompleted ? 14 : 16, weight: .light))
                            //                            .foregroundColor(task.isCompleted ? .accentColor : .white)
                            //                            .hLeading()
                        }
                        
                    //    .padding(.top)
                    }
                }
            }
            
            .foregroundColor(taskModel.isCurrentHour(date: task.taskDate ?? Date()) ? .white : .white)
            .padding(taskModel.isCurrentHour(date: task.taskDate ?? Date()) ? 15 : 0 )
           .padding(taskModel.isCurrentHour(date: task.taskDate ?? Date()) ? 0 : 15 )
            
            .hLeading()
            
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color("White"))
                    .shadow(radius: 2)
//                Color.blue
//                 .shadow(radius: 8)
//                    .cornerRadius(8)
                    .opacity(taskModel.isCurrentHour(date: task.taskDate ?? Date()) ? 1 : 1 )
                
            )
         
        
        }
       
        .hLeading()
    }
    
    
    // MARK: - header
    func HeaderView()->some View{
        
        HStack(spacing: 10){
            VStack(alignment: .leading, spacing: 10 ){
                Text("My List")
                    .font(.largeTitle.bold())
                Text(Date().formatted(date: .abbreviated, time: .omitted))
                    .foregroundColor(.gray)
            }
            .hLeading()
            //Edit Button
            EditButton()
//            Button{
//
//            } label: {
//   Image("profile")
//    .resizable()
//    .aspectRatio( contentMode: .fill)
//  .frame (width: 45, height: 45)
//  .clipShape(Circle())
//            }
        }
        
        
        .padding()
        .padding(.top,getSafeArea().top)
        .background(Color.white)
        }
    }


struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}


// MARK: - Ui design Helper func
extension View{
    func hLeading()->some View{
        self
            .frame(maxWidth: .infinity,alignment: .leading)
    }
    func hTrailing()->some View{
        self
            .frame(maxWidth: .infinity,alignment: .trailing)
    }
    func hCenter()->some View{
        self
            .frame(maxWidth: .infinity,alignment: .center)
    }
    // MARK: - SafeArea
    func getSafeArea()->UIEdgeInsets{
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else{
            return .zero
        }
        guard let safeArea = screen.windows.first?.safeAreaInsets else{
            return .zero
        }
        return safeArea
    }
}
