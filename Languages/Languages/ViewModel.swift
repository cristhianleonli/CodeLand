import Foundation

struct ViewModel {
    
    private let age: Int
    private let name: String
    
    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
    
    init() {
        self.name = "Cristhian"
        self.age = 26
    }
    
    var createButtonTitle: String {
        // Here we make use of our L10n constants file
        L10n.createButtonTitle
    }
    
    var titleText: String {
        L10n.homeTitle
    }
    
    var messageText: String {
        L10n.greetPersonTitle(name, age)
    }
}
