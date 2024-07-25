import Foundation
import SwiftUI

// Define a class that conforms to ObservableObject protocol
class MainViewModel: ObservableObject {
    @Published var showConfirmationAlert: Bool = false
    @Published var items: [MilestoneModel] = []
    
    // Track the item to be deleted
    @Published var itemToDelete: MilestoneModel? = nil

    // Request confirmation for deletion
    func requestDeleteConfirmation(for item: MilestoneModel) {
        self.itemToDelete = item
        self.showConfirmationAlert = true
    }
    
    // Initialize method, called when the object is created
    init() {
        getItems()
    }
    
    // Fetch initial data
    func getItems() {
        // Create a new MilestoneModel array with initial instances
        let newItems: [MilestoneModel] = []
        items.append(contentsOf: newItems)
    }
    
    // Add a new Milestone
    func addMilestone(
        title: String,
        targetDate: Date,
        displayFormat: String = "",
        backgroundColor: Color
    ) {
        // Create a new MilestoneModel instance
        let newMilestone = MilestoneModel(
            title: title,
            targetDate: targetDate,
            displayFormat: displayFormat,
            backgroundColor: backgroundColor
        )
        // Add the new milestone to the items array
        items.append(newMilestone)
    }
    
    // Delete milestone by index
    func deleteMilestone(at index: Int) {
        guard items.indices.contains(index) else { return }
        items.remove(at: index)
    }
    
    // Delete milestone by ID
    func deleteMilestonebyId(by id: UUID) {
        items.removeAll { $0.id == id }
        itemToDelete = nil // Reset the item to delete
        showConfirmationAlert = false
    }
    
    // Update milestone
    func updateMilestone(with newMilestone: MilestoneModel) {
        if let index = items.firstIndex(where: { $0.id == newMilestone.id }) {
            items[index] = newMilestone
        }
    }
}
