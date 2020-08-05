//
//  MainPresenter.swift
//  MyNotes
//
//  Created by admin on 26.06.2020.
//  Copyright © 2020 Natali. All rights reserved.
//

import Foundation
import UIKit

class MainPresenter: ViewToPresenterProtocol {
  
  
  var view: PresenterToViewProtocol?
  
  var interactor: PresenterToInteractorProtocol?

  var router: PresenterToRouterProtocol?
  
  func didScroll(offsrtY: CGFloat, contentHeight: CGFloat, frameHeight: CGFloat){
    print("didscroll in presenter")
    interactor?.dataToNextPage(offsetY: offsrtY, contentHeight: contentHeight, frameHeight: frameHeight)
  }
  
  func startFetchingPlaces() {
    print("start fetch from presenter")
    interactor?.getData()
  }
  
  func cellSelected(_ index : Int) {
    router?.created(with: index)
  }
  
//  func load(){
//    interactor?.load()
//  }
  
//  func fetchFromDatabaseSuccess(_ items: [Note] ){
//    let items = items.map { ViewModel(database: $0) }
//    view?.showPlaces(placesArray: items)
//  }
}


extension MainPresenter: InteractorToPresenterProtocol{
    func dataFetchedSuccess(with data: [Note]) {
      print("data fetch success")
      let items = data.map { ViewModel(item: $0) }
      view?.showPlaces(placesArray: items)
    }

    func noticeFetchFailed() {
      view?.showError()
    }
  
}

struct ViewModel {
  let id: Int
  let title: String
  let image: URL?
  var favorite: Bool
}
extension ViewModel {
  init(item: Note) {
    self.id = Int(item.id!)!
    self.title = item.title!
    self.image = URL(string: item.image!)
    self.favorite = item.favorite
  }
}

