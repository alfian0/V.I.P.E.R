//
//  ToDoListPresenterTest.swift
//  TooDoApp
//
//  Created by admin on 12/10/16.
//  Copyright © 2016 com.ios. All rights reserved.
//

import Foundation

import Quick
import Nimble

@testable import TooDoApp

class ToDoListPresenterTest: QuickSpec {

    override func spec() {
        var viewModel:ToDoListViewModel!
        let viewMock = ToDoListViewMock()
        let wireFrameMock = ToDoListWireFrameMock()
        let interceptorMock = ToDoListInterceptorMock()
        var presenter: ToDoListPresenter!
        
        beforeEach{
            viewModel = ToDoListViewModel()
            viewMock.resetMock()
            wireFrameMock.resetMock()
            interceptorMock.resetMock()
            presenter = ToDoListPresenter(view: viewMock, viewModel: viewModel, wireframe: wireFrameMock, interceptor: interceptorMock)
            interceptorMock.presenter = presenter
            
        }
        
        // do initial setup
        describe("Presenter Loading View and updating View Actions") {
            it("doInitialSetup should hookup view events") {
                presenter.doInitialSetup()
                expect(viewMock.invocations.count) == 1
                expect(viewMock.invocations).to(contain("hoookUpEvents()"))
                expect(interceptorMock.invocations.count) == 0
            }

            it("get Todos should get list of Todos from Interceptor") {
                presenter.getTodos()
                
                expect(viewMock.invocations.count) == 3
                expect(viewMock.invocations).to(contain("showLoading()"))
                expect(viewMock.invocations).to(contain("hideLoading()"))
                expect(viewMock.invocations).to(contain("redisplayTodos()"))
                expect(interceptorMock.invocations.count) == 1
                expect(interceptorMock.invocations).to(contain("getTodos()"))
                
                expect(viewModel.todos?.count) == 2
                
            }
            
            it("refresh Button should refresh list of Todos from Interceptor") {
                presenter.refreshButtonPressed()
                
                expect(viewMock.invocations.count) == 3
                expect(viewMock.invocations).to(contain("showLoading()"))
                expect(viewMock.invocations).to(contain("hideLoading()"))
                expect(viewMock.invocations).to(contain("redisplayTodos()"))
                expect(interceptorMock.invocations.count) == 1
                expect(interceptorMock.invocations).to(contain("getTodos()"))
                
                expect(viewModel.todos?.count) == 2
                
            }

            it("deleteItemAtIndex should delete Todos iterm from Interceptor") {
                viewModel.todos = [TodoItem(identifier: "id1",description: "Item 1"),
                                   TodoItem(identifier: "ida",description: "Item 2")]

                presenter.deleteItemAtIndex(1)
                
                expect(viewMock.invocations.count) == 4
                expect(viewMock.invocations).to(contain("showLoading()"))
                expect(viewMock.invocations).to(contain("hideLoading()"))
                expect(viewMock.invocations).to(contain("redisplayTodos()"))
                expect(interceptorMock.invocations.count) == 2
                expect(interceptorMock.invocations).to(contain("getTodos()"))
                expect(interceptorMock.invocations).to(contain("deleteTodoWithID(ida)"))
                
                expect(viewModel.todos?.count) == 2
                expect(viewModel.todos?[1].identifier) == "id2"
                
            }

            it("deleteItemAtIndex should show error if the index is not correct") {
                viewModel.todos = [TodoItem(identifier: "id1",description: "Item 1"),
                                   TodoItem(identifier: "id2",description: "Item 2")]
                
                presenter.deleteItemAtIndex(2)
                
                expect(viewMock.invocations.count) == 1
                expect(viewMock.invocations).to(contain("showErrorMessage(Cannot delete this item)"))
                expect(interceptorMock.invocations.count) == 0
                
                
                expect(viewModel.todos?.count) == 2
                
            }

            
            it("deleteItemAtIndex should show error if todo item id is nil") {
                viewModel.todos = [TodoItem(identifier: "id1",description: "Item 1"),
                                   TodoItem(identifier: nil,description: "Item 2")]
                
                presenter.deleteItemAtIndex(1)
                
                expect(viewMock.invocations.count) == 1
                expect(viewMock.invocations).to(contain("showErrorMessage(Cannot delete this item)"))
                expect(interceptorMock.invocations.count) == 0
                
                
                expect(viewModel.todos?.count) == 2
                
            }

            

        }
        
        describe("Presenter Navigation Actions") {
            it("addButtonPressed should take call wireframe to navigate to Add Todo Screen") {
                presenter.addButtonPressed()
                
                expect(wireFrameMock.invocations.count) == 1
                expect(wireFrameMock.invocations).to(contain("presentAddModule()"))
            }
            
            it("selectedItemAtIndex should take call wireframe to edit todo item passing todo item") {
                viewModel.todos = [TodoItem(identifier: "id1",description: "Item 1"),
                                   TodoItem(identifier: "id2",description: "Item 2")]
                presenter.selectedItemAtIndex(1)
                
                expect(wireFrameMock.invocations.count) == 1
                expect(wireFrameMock.invocations).to(contain("presentEditModule(id2)"))
            }

        }

        describe("Presenter Handle Interceptor failures") {
            it("failedToGetTodos should show error message when failed to load ToDo list") {
                presenter.failedToGetTodos(NSError(domain: "todo", code: 1, userInfo :[:]))
                
                expect(viewMock.invocations.count) == 2
                expect(viewMock.invocations).to(contain("hideLoading()"))
                expect(viewMock.invocations).to(contain("showErrorMessage(The operation couldn’t be completed. (todo error 1.))"))
            }
            
            it("failedToDeleteTodo should show error message when failed to delete ToDo Item") {

                presenter.failedToDeleteTodo(NSError(domain: "todo", code: 2, userInfo :[:]))
                
                expect(viewMock.invocations.count) == 5
                expect(viewMock.invocations).to(contain("hideLoading()"))
                expect(viewMock.invocations).to(contain("showErrorMessage(The operation couldn’t be completed. (todo error 2.))"))
                expect(viewMock.invocations).to(contain("showLoading()"))
                expect(viewMock.invocations).to(contain("redisplayTodos()"))
                expect(interceptorMock.invocations.count) == 1
                expect(interceptorMock.invocations).to(contain("getTodos()"))
            }
            
        }
        
        describe("Presenter Handling view data calls") {
            it("numberOfTodos should return number of Todos in view model") {
                viewModel.todos = [TodoItem(identifier: "id1",description: "Item 1"),
                                   TodoItem(identifier: "id2",description: "Item 2")]
                
                expect(presenter.numberOfTodos) == 2
            }
            
            it("todoItemDescriptionAtIndex should show error message when failed to delete ToDo Item") {
                viewModel.todos = [TodoItem(identifier: "id1",description: "Item 1"),
                                   TodoItem(identifier: "id2",description: "Item 2")]
                
                expect(presenter.todoItemDescriptionAtIndex(1)) == "Item 2"
            }
            
        }
        
        
    }

}