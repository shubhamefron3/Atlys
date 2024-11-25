//
//  ViewModel.swift
//  Atlys.com
//
//  Created by MacBook on 25/11/24.
//

import Foundation

protocol LaunchScreenViewModelInputProtocol {
    var countriesImagesCarousel: [String] { get }
}

protocol LaunchScreenViewModelOutputProtocol {}

protocol LaunchScreenViewModelTypeProtocol {
    var input: LaunchScreenViewModelInputProtocol? {get}
}

final class LaunchScreenViewModel: LaunchScreenViewModelTypeProtocol,
                                   LaunchScreenViewModelInputProtocol {
    
    var input:LaunchScreenViewModelInputProtocol? { return self }
    var delegate:LaunchScreenViewModelOutputProtocol?
    
    var countriesImagesCarousel: [String] {
        return ["India","Greece","Italy","Turkey"]
    }
    
    init(from delegate: LaunchScreenViewModelOutputProtocol){
        self.delegate = delegate
    }
}
