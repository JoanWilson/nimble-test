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
            self.viewModel.fetchSurveyrs()
        }
        navigationController?.delegate = self
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
                self.loadingView.dismiss()
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

class CrossDissolveTransitionAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5 // Adjust the duration as needed
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromView = transitionContext.view(forKey: .from),
              let toView = transitionContext.view(forKey: .to) else {
            return
        }

        let containerView = transitionContext.containerView

        toView.alpha = 0.0
        containerView.addSubview(toView)

        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            toView.alpha = 1.0
            fromView.alpha = 0.0
        }) { _ in
            fromView.alpha = 1.0
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }
}
