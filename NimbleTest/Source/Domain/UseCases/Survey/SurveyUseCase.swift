import Foundation

protocol SurveyUseCase {
    func loadSurveys() async throws -> SurveyData?
}
