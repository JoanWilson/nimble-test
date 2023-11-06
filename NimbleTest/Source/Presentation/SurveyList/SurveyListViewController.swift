import SwiftUI

public final class SurveyListViewController: UIViewController {
    private var contentView = SurveyListView()
    private var repository = SurveyRepository(session: .shared)
    private var userRepository = UserRepository(session: .shared)
    
    private let viewModel: SurveyListViewModel
    
    init(viewModel: SurveyListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }
    
    public override func loadView() {
        super.loadView()
        view = contentView
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupSwipeGesture()
        viewModel.fetchSurveyrs()
        addBinders()
    }
    
    private func addBinders() {
        addSurveysBinder()
    }
    
    private func addSurveysBinder() {
        viewModel.$surveys.sink { surveys in
            DispatchQueue.main.async {
                self.contentView.pageControl.numberOfPages = surveys.count
                guard let first = surveys.first else {
                    return
                }
                self.contentView.updateView(with: first)
            }
        }.store(in: &viewModel.cancellable)
    }
    
    private func setupNavigationBar() {
        navigationItem.hidesBackButton = true
        navigationController?.isNavigationBarHidden = true
    }
    
    private func setupSwipeGesture() {
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
                    let index = self.contentView.pageControl.currentPage
                    
                    self.contentView.updateView(with: self.viewModel.surveys[index])
                }, completion: nil)
            } else {
                UIView.transition(with: contentView, duration: 0.5, options: .transitionCrossDissolve, animations: {
                    self.contentView.surveyTitle.text = "Right"
                    self.contentView.pageControl.currentPage += 1
                    self.contentView.backgroundImage.image = UIImage(named: "Images/surveyBackground")
                    let index = self.contentView.pageControl.currentPage
                    self.contentView.updateView(with: self.viewModel.surveys[index])
                }, completion: nil)
            }
        }
    }
    
    func loadSurvey() {
        Task {
            let session = try await repository.loadSurveys() 
            
            switch session {
            case .success(let survey):
                for item in survey.data {
                    print(item.attributes.title)
                }
                contentView.pageControl.numberOfPages = survey.data.count
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func loadUserData() {
        Task {
            let session = try await userRepository.loadUserData()
            
            switch session {
            case .success(let userData):
                let userImageString = userData.attributes.avatarURL
                let url = URL(string: userImageString)!
                DispatchQueue.main.async {
                    self.contentView.userPicture.load(url: url)
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
