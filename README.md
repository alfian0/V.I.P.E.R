# iOSBootCamp
iOS Boot Camp

1. Create VIPER template use ruby script

    ```Swift
    ruby scripts/generator.rb -m "SignUp" -t ./templates -w TooDoApp/TooDoApp/Modules -u TooDoApp/TooDoAppTests/Modules -a "<Your name>"
    ```
    
2. Import generated file to project
3. Add Modules.swift path to Module

    ```Swift
    case .SignUp:
        return "/Modules/SignUp"
    ```
    
4. Add module to AppRouter.swift

    ```Swift
    Module.SignUp.routePath : {(appRouter: IAppRouter) in SignUpModule(appRouter: appRouter)}
    ```
    
5. Un-commented this code on SignUpModule.swift

    ```Swift
    let wireframe = appRouter.resolver.resolve(ISignUpWireFrame.self, argument:appRouter)!
        wireframe.present(SignUpViewModel())
    ```
    
6. Add some protocol needed, example: we want show SignUp screen  and show List of todo after SignUp

    ```Swift
    func presentView(viewModel:SignUpViewModel)
    func showListScreen()
    ```
    
7. Add method in SignUp presenter and Interface to do SignUp

    ```Swift
    func doSignUp(email: String?, password: String?, confirmPassword: String?)
    func didSignUp(user: User)
    func failedToSignUp(error: NSError?)
    ```
    
8. Un-wrapped all optional value to check not get nil value
9. Make sure all view action registered to viewInterface

    ```Swift
    func showLoading()
    func hideLoading()
    func showErrorMessage(message: String)
    ```
    
10. Add service on Interactor

    ```Swift
    let service:ITodoService
    
    init(service:ITodoService){
    
       self.service = service
       
    }
    ```





# Step to create Unit Test

1. Make sure All file `Target Membership` can accessed by `<#AppName>Test` and `<#AppName>UITest`
2. Create Mock, Make sure pod already have MockFive installed
3. Make all presenter test case
