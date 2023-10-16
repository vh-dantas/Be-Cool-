import Foundation
import UIKit

// Funções para vibrar o celular
final class Vibration{
    static let shared = Vibration()
    
    private init() {}
    
    func selectionVibration(){
        DispatchQueue.main.async {
            let selectionFeedBackGenerator = UISelectionFeedbackGenerator()
            selectionFeedBackGenerator.prepare()
            selectionFeedBackGenerator.selectionChanged()
        }
    }
    
    func vibrate(for type: UINotificationFeedbackGenerator.FeedbackType){
        DispatchQueue.main.async {
            let notificationGenerator = UINotificationFeedbackGenerator()
            notificationGenerator.prepare()
            notificationGenerator.notificationOccurred(type)
        }
    }
    
    func vibrate2(for type: UIImpactFeedbackGenerator.FeedbackStyle) {
        DispatchQueue.main.async {
            let feedbackGenerator = UIImpactFeedbackGenerator(style: type)
            feedbackGenerator.impactOccurred()
        }
    }
}
