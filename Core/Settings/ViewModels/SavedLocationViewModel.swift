//
//  SavedLocationViewModel.swift
//  Uber
//
//  Created by Alexander Sorokin on 30.07.2023.
//

import Foundation

enum SavedLocationViewModel: Int, CaseIterable, Identifiable {
    case home
    case work
    
    var id: Int { return self.rawValue }
    
    var title: String {
        switch self {
            case .home: return "Home"
            case .work: return "Work"
        }
    }
    
    var subtitle: String {
        switch self {
            case .home: return "Add Home"
            case .work: return "Add Work"
        }
    }
    
    var imageName: String {
        switch self {
            case .home: return "house.circle.fill"
            case .work: return "archivebox.circle.fill"
        }
    }
    
    var databaseKey: String {
        switch self {
            case .home: return "homeLocation"
            case .work: return "workLocation"
        }
    }
    
    func subtitle(forUser user: User) -> String{
        switch self {
            case .home:
                if let homeLocation = user.homeLocation {
                    return homeLocation.title
                } else {
                    return "Add Home"
                }
            case .work:
                if let workLocation = user.workLocation {
                    return workLocation.title
                } else {
                    return "Add Work"
                }
        }
    }
}
