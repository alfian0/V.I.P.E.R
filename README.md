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

    ```Swift
    import Foundation
    import MockFive

    class SignUpViewMock: ISignUpView, Mock {
        let mockFiveLock: String = lock()
    
        func showLoading() {
            stub(identifier: "show Loading")
        }
    
        func hideLoading() {
            stub(identifier: "hide Loading")
        }
    
        func showErrorMessage(message: String) {
            stub(identifier: "show Error Message", arguments: message)
        }
    }
    ```
    
    ```Swift
    import Foundation
    import MockFive

    class SignUpWireFrameMock: ISignUpWireFrame, Mock {
        let mockFiveLock: String = lock()
    
        func presentView(viewModel: SignUpViewModel) {
            stub(identifier: "present View")
        }
    
        func showListScreen() {
            stub(identifier: "show List Screen")
        }
    }
    ```
    
    ```Swift
    import Foundation
    import MockFive

    class SignUpIteractorMock: ISignUpInteractor, Mock {
        let mockFiveLock: String = lock()
    
        var _presenter: ISignUpPresenter?
    
        var presenter : ISignUpPresenter?{
            set { _presenter = newValue }
            get { return _presenter }
        }
    
        func signUp(email: String, password: String, confirmPassword: String) {
            stub(identifier: "sign Up", arguments: [email, password, confirmPassword])
            _presenter?.doSignUp(email, password: password, confirmPassword: confirmPassword)
        }
    }
    ```
    
    ```Swift
    import Foundation
    import Quick
    import Nimble

    @testable import TooDoApp

    class SignUpPresenterTest: QuickSpec {
        override func spec() {
            var viewModel:SignUpViewModel!
            let viewMock = SignUpViewMock()
            let wireFrameMock = SignUpWireFrameMock()
            let interceptorMock = SignUpIteractorMock()
            var presenter: SignUpPresenter!
        
            beforeEach{
                viewModel = SignUpViewModel()
                viewMock.resetMock()
                wireFrameMock.resetMock()
                interceptorMock.resetMock()
                presenter = SignUpPresenter(view: viewMock, viewModel: viewModel, interactor: interceptorMock, wireframe: wireFrameMock)
                interceptorMock.presenter = presenter
            }
        }
    }
    ```
    
3. Make all presenter test case

    ```Swift
    describe("Sign Up Test") {
            it("Invalid Sign Up : Invalid Email Address", closure: {
                presenter.doSignUp("", password: "", confirmPassword: "")
                expect(viewMock.invocations.count) == 1
                expect(viewMock.invocations).to(contain("showErrorMessage(Please enter a valid email)"))
            })
            
            it("Invalid Sign Up : Invalid Password", closure: { 
                presenter.doSignUp("alfiansyah@go-jek.com", password: "", confirmPassword: "")
                expect(viewMock.invocations.count) == 1
                expect(viewMock.invocations).to(contain("showErrorMessage(Please enter a valid password)"))
            })
            
            it("Invalid Sign Up : Confirm password did not match", closure: {
                presenter.doSignUp("alfiansyah@go-jek.com", password: "password", confirmPassword: "")
                expect(viewMock.invocations.count) == 1
                expect(viewMock.invocations).to(contain("showErrorMessage(Your password and confirm password did not match)"))
            })
    }
    ```
