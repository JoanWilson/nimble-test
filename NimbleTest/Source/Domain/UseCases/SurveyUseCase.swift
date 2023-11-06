import Foundation

protocol SurveyUseCase {
    func loadSurveys() async throws -> Result<SurveyData, RepositoryError> 
}
