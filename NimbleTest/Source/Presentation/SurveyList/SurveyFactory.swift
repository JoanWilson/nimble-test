import UIKit

public enum SurveyFactory {
    static public func makeViewController() -> UIViewController {
        let surveyUseCase = SurveyRepository(session: .shared)
        let viewModel = SurveyListViewModel(surveyUseCase: surveyUseCase)
        let viewController = SurveyListViewController(viewModel: viewModel)

        return viewController
    }
}
