//
//  SearchViewModel.swift
//  WeatherApp
//
//  Created by 이원빈 on 2024/07/23.
//

import RxSwift
import RxRelay

protocol SearchViewModelInput {
    func fetchCityList()
}

protocol SearchViewModelOutput {
    var searchQueryList: BehaviorRelay<[SearchQueryCellData]> { get }
}

protocol SearchViewModel: SearchViewModelInput, SearchViewModelOutput {}

// MARK: Outputs
struct DefaultSearchViewModel: SearchViewModel {
    
    var searchQueryList: RxRelay.BehaviorRelay<[SearchQueryCellData]> = .init(value: [])
    
    private var disposeBag = DisposeBag()
    private let fetchCityUseCase: FetchCityUseCase
    
    init(fetchCityUseCase: FetchCityUseCase) {
        self.fetchCityUseCase = fetchCityUseCase
    }
}

// MARK: Inputs
extension DefaultSearchViewModel {
    
    func fetchCityList() {
        let cityList = fetchCityUseCase.execute()
        searchQueryList.accept(cityList.map { $0.toSearchQueryCellData() })
    }
}
