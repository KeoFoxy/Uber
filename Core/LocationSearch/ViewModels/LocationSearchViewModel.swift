//
//  LocationSearchViewModel.swift
//  Uber
//
//  Created by Alexander Sorokin on 18.07.2023.
//

import Foundation
import MapKit

class LocationSearchViewModel: NSObject, ObservableObject {
    // MARK: Properties
    
    @Published var results = [MKLocalSearchCompletion]()
    @Published var selectedLocation: String?
    
    private let searchCompleter = MKLocalSearchCompleter()
    var queryFragment: String = "" {
        didSet {
            searchCompleter.queryFragment = queryFragment
        }
    }
    
    //MARK: Lifecycle
    
    override init() {
        super.init()
        searchCompleter.delegate = self
        searchCompleter.queryFragment = queryFragment
    }
    
    //MARK: Helpers
    
    func selectLocation(_ location: String) {
        self.selectedLocation = location
        print("DEBUG: Selected location is \(self.selectedLocation)")
    }
}

// MARK: - MKLocalSearchCompleterDelegate

extension LocationSearchViewModel: MKLocalSearchCompleterDelegate {
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        self.results = completer.results
    }
}
