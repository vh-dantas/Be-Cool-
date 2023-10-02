//
//  DAO.swift
//  BurnoutEditionMini02
//
//  Created by João Victor Bernardes Gracês on 26/09/23.
//

import Foundation
import CoreData
import UIKit

class DataAcessObject {
    // Singleton
    static let shared = DataAcessObject()
    
    // Referencia do moc
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    // Função para salvar os dados - salvar o contexto
    func saveContext (){
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    
    // Funçao de buscar Meta - Goal
    func fetchGoal() -> [Goal] {
        do {
            // Criando a requisição no banco
            let request = NSFetchRequest<Goal>(entityName: "Goal")
            // Criando a ordenação dos dados, serão ordeanos pela data de criação de forma decrescente
            let sort = NSSortDescriptor(key: "createdDate", ascending: false)
            request.sortDescriptors = [sort]
            // Busca no banco todos os Goals salvos
            let items = try context.fetch(request)
            return items
        } catch {
            print("Erro em buscar as Goals - retornando uma array vazia")
            return []
        }
    }
    
    
    // Criando uma nova Meta - Goal
    func createGoal(title: String) {
        // Criando uma instancia de Goal
        let newGoal = Goal(context: context)
        newGoal.id = UUID()
        newGoal.title = title
        newGoal.isCompleted = false  // isCompleted começa falso pois não começa completa
        newGoal.createdDate = Date()
        // Salvando os dados
        saveContext()
    }
    
    // Busca pelas Sub metas - subgoals
    func fetchSubGoals(goal: Goal) -> [SubGoal]{
        if let goalSubGoals = goal.subGoals?.allObjects as? [SubGoal] {
            return goalSubGoals
        }
        print("Erro ao puxar as subgoals")
        // Retorna vazio caso não sejam obejtos SubGoals
        return []
        
    }
    
    // Criando uma Sub meta - SubGoal
    func createSubGoal(title: String, type: String, goal: Goal){
        let newSubGoal = SubGoal(context: context)
        newSubGoal.id = UUID()
        newSubGoal.title = title
        newSubGoal.type = type
        newSubGoal.isCompleted = false
        newSubGoal.goal = goal
        // Salvando os dados
        saveContext()
    }
    
    // Atualizando uma Sub meta - SubGoal
    func updateSubGoal(_ subGoal: SubGoal, title: String){
        subGoal.title = title
        // Salvando os dados
        saveContext()
    }
    
    // Excluindo uma Meta - Goal
    func deleteGoal(goal: Goal){
        context.delete(goal)
        saveContext()
    }
    
    // Excluindo uma Sub meta - SubGoal
    func deleteSubGoal(subGoal: SubGoal){
        context.delete(subGoal)
        saveContext()
    }
}
