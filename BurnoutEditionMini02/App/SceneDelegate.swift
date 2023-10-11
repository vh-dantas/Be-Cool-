//
//  SceneDelegate.swift
//  BurnoutEditionMini02
//
//  Created by Victor Dantas on 20/09/23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let windowScene = (scene as? UIWindowScene) else { return }
       
        //Configurando o Onboarding
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let swipingController = OnboardingViewController(collectionViewLayout: layout)
      
        
        
        // Instância da Tab Bar Controller
        let tabBarController = UITabBarController()
        
        // Instância e configuração de NavController da Reflection
        let navConReflection = UINavigationController(rootViewController: ReflectionViewController())
        let navHome = UINavigationController(rootViewController: GoalsViewController())
        
        // Instâncias das View Controllers para a Tab Bar
        let goalsVC = navHome
        let achievementsVC = UINavigationController(rootViewController: AchievementsViewController())
        let reflectionVC = navConReflection
        let settingsVC = UINavigationController(rootViewController: SettingsViewController())
        
        // UserDefauls para armazanar a visualização do onboarding
        let onboardingCompleted = UserDefaults.standard.bool(forKey: "Onboarding")
        // Verificando se o Onbording ja foi concluido - se sim tiramos ele da lista de viewControllers
        if onboardingCompleted {
            // Atribuição das ViewController à Tab Bar
            tabBarController.viewControllers = [goalsVC, achievementsVC, reflectionVC, settingsVC]
        } else {
            // Atribuição das ViewController à Tab Bar

            tabBarController.viewControllers = [ goalsVC, achievementsVC, reflectionVC, settingsVC]
        }
     

        // Configuração dos Tab Bar Itens
        goalsVC.tabBarItem = UITabBarItem(title: "goals".localized, image: UIImage(systemName: "list.bullet.circle"), selectedImage: UIImage(systemName: "list.bullet.circle.fill"))
        achievementsVC.tabBarItem = UITabBarItem(title: "achievements".localized, image: UIImage(systemName: "medal"), selectedImage: UIImage(systemName: "medal.fill"))
        reflectionVC.tabBarItem = UITabBarItem(title: "reflections".localized, image: UIImage(systemName: "text.bubble"), selectedImage: UIImage(systemName: "text.bubble.fill"))
        settingsVC.tabBarItem = UITabBarItem(title: "settings".localized, image: UIImage(systemName: "gearshape"), selectedImage: UIImage(systemName: "gearshape.fill"))
        
        
        // Configuração da janela, atribuindo à rootView (Necessário ao retirar o arquivo .storyboard)
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()

    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.

        // Save changes in the application's managed object context when the application transitions to the background.
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }


}

