import Foundation
import Combine

public final class SurveyListViewModel {
    
    @Published internal var surveys: [Survey] = []
    @Published internal var userData: User? = nil
    @Published internal var isFetched: Bool = false
    
    internal var cancellable: Set<AnyCancellable> = []
    
    private let surveyUseCase: SurveyUseCase
    private let userUseCase: UserUseCase
    
    init(surveyUseCase: SurveyUseCase, userUseCase: UserUseCase) {
        self.surveyUseCase = surveyUseCase
        self.userUseCase = userUseCase
    }
    
    func fetchSurveyrs() async throws{
            let session = try await surveyUseCase.loadSurveys()
            
            switch session {
            case .success(let survey):
                surveys.append(contentsOf: survey.data)
                try await fetchUserData()
            case .failure(let error):
                print(error)
            }
    }
    
    func fetchUserData() async throws {
        let session = try await userUseCase.loadUserData()
            
            switch session {
            case .success(let userData):
                self.userData = userData
                isFetched = true
            case .failure(let error):
                print(error)
            }
    }
}
