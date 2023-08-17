//
//  OnboardingViewModel.swift
//  Seeker
//
//  Created by Filipe Serafini on 17/08/23.
//

import Foundation
import SwiftUI

class OnboardingViewModel: ObservableObject {
    
    @Published var userAlreadyOnCK: Bool = false
    var userManager: UserManager

    init(userManager: UserManager) {
        self.userManager = userManager
        self.checkUserAlreadyOnCK()
    }
    
    func checkUserAlreadyOnCK() {
        userManager.checkUserAlreadyOnCK()
        
        if !userManager.userOnCK.isEmpty {
            self.userAlreadyOnCK = true
        }
    }
    
}
