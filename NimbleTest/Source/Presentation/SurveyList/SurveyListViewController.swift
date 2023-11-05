import SwiftUI

public final class SurveyListViewController: UIViewController {
    private var contentView = SurveyListView()
    private var repository = SurveyRepository(session: .shared)
    private var titleView = UIHostingController(rootView: TitleView(dayTitle: "Today", descriptiveTitle: "MONDAY, JUNE 15", userPicture: UIImage(named: "Images/userPic")!))
    
    public override func loadView() {
        super.loadView()
        view = contentView
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        loadSurvey()
        navigationItem.hidesBackButton = true
        navigationController?.isNavigationBarHidden = true
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
        contentView.addGestureRecognizer(panGesture)
    }
    
    @objc func handlePan(_ gesture: UIPanGestureRecognizer) {
        if gesture.state == .ended {
            let translation = gesture.translation(in: self.view)
            if translation.x > 0 {
                UIView.transition(with: contentView, duration: 0.5, options: .transitionCrossDissolve, animations: {
                    self.contentView.surveyTitle.text = "Left"
                    self.contentView.pageControl.currentPage -= 1
                    self.contentView.backgroundImage.image = UIImage(named: "Images/loginBackground")
                }, completion: nil)
            } else {
                UIView.transition(with: contentView, duration: 0.5, options: .transitionCrossDissolve, animations: {
                    self.contentView.surveyTitle.text = "Right"
                    self.contentView.pageControl.currentPage += 1
                    self.contentView.backgroundImage.image = UIImage(named: "Images/surveyBackground")

                }, completion: nil)
            }
        }
    }
    
    func loadSurvey() {
        Task {
            guard let session = try await repository.loadSurveys() else {
                return
            }
            
            
            for survey in session.data {
                print(survey.attributes.title)
            }
        }
    }
}
