import SwiftUI

public final class SurveyListViewController: UIViewController {
    
    private var contentView = SurveyListView()
    private var loadingView = LoadingViewController()
    
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
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupSwipeGesture()
        addBinders()
        contentView.detailButton.addTarget(self, action: #selector(detailButtonTapped), for: .touchUpInside)
        loadingView.modalTransitionStyle = .crossDissolve
        loadingView.modalPresentationStyle = .overCurrentContext
        present(loadingView, animated: true) {
            Task {
                do {
                    
                    try await self.viewModel.fetchSurveyrs()
                } catch let error {
                    print(error)
                }
            }
        }
        navigationController?.delegate = self
    }
    
    private func addBinders() {
        addSurveysBinder()
        addUserBinder()
        addIsFetchedBinder()
    }
    
    private func addIsFetchedBinder() {
        viewModel.$isFetched.sink { isFetched in
            if isFetched  {
                DispatchQueue.main.async {
                    self.loadingView.dismiss()
                }
            }
        }.store(in: &viewModel.cancellable)
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
    
    private func addUserBinder() {
        viewModel.$userData.sink { user in
            guard let userPicString = user?.data.attributes.avatarURL else { return }
            guard let url = URL(string: userPicString) else { return }
            self.contentView.userPicture.load(url: url)
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
    
    @objc func detailButtonTapped() {
        DispatchQueue.main.async {
            let viewController = DetailViewController(
                title: self.contentView.surveyTitle.text!,
                description: self.contentView.descriptionTitle.text!,
                backgroundImage: self.contentView.backgroundImage.image!
            )
            self.navigationController?.pushViewController(viewController, animated: true)
            self.navigationController?.isNavigationBarHidden = false
            self.navigationItem.hidesBackButton = false
        }
    }
}

extension SurveyListViewController: UINavigationControllerDelegate {
    public func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
                return CrossDissolveTransitionAnimator()
        }
}
