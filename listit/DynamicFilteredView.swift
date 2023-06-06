//
//  DynamicFilteredView.swift
//  listit!!
//
//  Created by Arwamohammed07 on 08/08/1444 AH.
//

import SwiftUI
import CoreData

struct DynamicFilteredView<Content : View, T>: View where T: NSManagedObject {
    // MARK: -  Core Data Request
    @FetchRequest var request : FetchedResults<T>
    let content: (T)->Content
    
// MARK: - BUlding Custom ForEach which will give  coredata object to bund View
    init(dateToFilter: Date, @ViewBuilder content: @escaping (T)->Content){
        // MARK: -  predicate to filter current date tasks
        let calender = Calendar.current
        
        let today = calender.startOfDay(for: dateToFilter)
        // MARK: -         let tommorow = calender.date(byAdding: .day, value: 1, to: dateToFilter)!
        let tommorow = calender.date(byAdding: .day, value: 1, to: today)!

        // MARK: - filter key
        let filterKey = "taskDate"
        
        // MARK: - this will fetch task between today and tommorow which is 24 hour
        let predicate = NSPredicate(format: "\(filterKey)>= %@ AND \(filterKey) < %@", argumentArray: [today,tommorow])
        
        // MARK: - intializing Requst with NSPredicate
        // MARK: - adding sort
        _request = FetchRequest(entity: T.entity(), sortDescriptors: [.init(keyPath: \Lola.taskDate, ascending: true )], predicate: predicate)
        self.content = content
    }
    
    var body: some View {
        // MARK: - 
        Group{
            if request.isEmpty{
                Text("No Tasks Here!!")
                    .foregroundColor(.secondary)
                    .font(.system(size: 16))
                    .fontWeight(.light)
                    .offset(y:100)
            }
            else{
                ForEach(request,id: \.objectID){ object in
                    self.content(object)
                }
                
            }
        }
        
    }
}

