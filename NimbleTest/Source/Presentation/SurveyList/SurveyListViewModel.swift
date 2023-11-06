import Foundation
import Combine

public final class SurveyListViewModel {
    
    @Published internal var surveys: [Survey] = []
    
    internal var cancellable: Set<AnyCancellable> = []
    
    private let surveyUseCase: SurveyUseCase
    
    init(surveyUseCase: SurveyUseCase) {
        self.surveyUseCase = surveyUseCase
    }
    
    func fetchSurveyrs() {
        Task {
            let session = try await surveyUseCase.loadSurveys()
            
            switch session {
            case .success(let survey):
                surveys.append(contentsOf: survey.data)
            case .failure(let error):
                print(error)
            }
        }
    }
}
