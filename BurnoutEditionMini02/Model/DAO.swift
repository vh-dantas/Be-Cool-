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
    func createGoal(title: String) -> Goal {
        // Criando uma instancia de Goal
        let newGoal = Goal(context: context)
        newGoal.id = UUID()
        newGoal.title = title
        newGoal.isCompleted = false  // isCompleted começa falso pois não começa completa
        newGoal.createdDate = Date()
        // Salvando os dados
        saveContext()
        return newGoal
    }
    
    func createReflection(refName: String, mood: String, randomRefQST: String, randomRefANS: String, drawing: UIImageView?, image: UIImageView?, goal: Goal?) {
        let newReflection = ReflectionEntity(context: context)
        newReflection.id = UUID()
        newReflection.date = Date()
        newReflection.mood = mood
        newReflection.randomRefAns = randomRefANS
        newReflection.randomRefQst = randomRefQST
        if let image = drawing?.image {
            if let imageData = image.pngData() {
                newReflection.drawing = imageData
            }
        }
        if let image = image?.image {
            if let imageData = image.pngData() {
                newReflection.image = imageData
            }
        }
        // Caso nao seja vazio a goal ele cria o relacionamento
        newReflection.refName = refName
        if let goal = goal {
            newReflection.goal = goal
        }
        saveContext()
    }
    
    // Funçao de buscar Meta - ReflectionEntity
    func fetchReflection() -> [ReflectionEntity] {
        do {
            // Criando a requisição no banco
            let request = NSFetchRequest<ReflectionEntity>(entityName: "ReflectionEntity")
            // Criando a ordenação dos dados, serão ordeanos pela data de criação de forma decrescente
            let sort = NSSortDescriptor(key: "date", ascending: false)
            request.sortDescriptors = [sort]
            // Busca no banco todos os Reflection salvos
            let items = try context.fetch(request)
            return items
        } catch {
            print("Erro em buscar as Goals - retornando uma array vazia")
            return []
        }
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
    
//    func fetchWorkSubGoals(goal: Goal) -> [SubGoal]{
//        let workGoals = goal.subGoals?.filter {
//    }
    
    // Criando uma Sub meta - SubGoal
    func createSubGoal(title: String, type: SubGoalType, level: Difficulty?, goal: Goal, date: Date?){
        let newSubGoal = SubGoal(context: context)
        newSubGoal.id = UUID()
        newSubGoal.title = title
        newSubGoal.type = type.rawValue
        newSubGoal.level = level?.rawValue
        newSubGoal.isCompleted = false
        newSubGoal.goal = goal
        newSubGoal.date = date?.ISO8601Format()
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
    
    // Mudando se a submeta tá completa ou não
    func toggleIsCompleted(subGoal: SubGoal){
           subGoal.isCompleted.toggle()
           saveContext()
       }
    
    // Mudando se a meta principal tá completa ou não
    func toggleIsCompleted(goal: Goal) {
        goal.isCompleted.toggle()
        saveContext()
    }
}
