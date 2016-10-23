# iOSBootCamp
iOS Boot Camp

1. Create VIPER template use ruby script
    `ruby scripts/generator.rb -m "SignUp" -t ./templates -w TooDoApp/TooDoApp/Modules -u TooDoApp/TooDoAppTests/Modules -a "<Your name>"`
2. Import generated file to project
3. Add Modules.swift path to Module
    `case .SignUp:` ---
      `return "/Modules/SignUp"`
4. Add module to AppRouter.swift
    `Module.SignUp.routePath : {(appRouter: IAppRouter) in SignUpModule(appRouter: appRouter)}`
5. Un-commented this code on SignUpModule.swift
    `let wireframe = appRouter.resolver.resolve(ISignUpWireFrame.self, argument:appRouter)!`
    `wireframe.present(SignUpViewModel())`
6. Add some protocol needed, example: we want show SignUp screen  and show List of todo after SignUp
    `func presentView(viewModel:SignUpViewModel)`
    `func showListScreen()`
7. Add method in SignUp presenter and Interface to do SignUp
    `func doSignUp(email: String?, password: String?, confirmPassword: String?)`
    `func didSignUp(user: User)`
    `func failedToSignUp(error: NSError?)`
8. Un-wrapped all optional value to check not get nil value
9. Make sure all view action registered to viewInterface
    `func showLoading()`
    `func hideLoading()`
    `func showErrorMessage(message: String)`
10. Add service on Interactor
    `let service:ITodoService
    
    `init(service:ITodoService){`
       `self.service = service`
    `}`
