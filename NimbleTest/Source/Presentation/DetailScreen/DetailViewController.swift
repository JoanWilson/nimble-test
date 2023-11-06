import SwiftUI

public class DetailViewController: UIViewController {
    
    private var contentView = DetailView()
    
    public override func loadView() {
        super.loadView()
        view = contentView
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupBackButton()
    }

    public init(title: String, description: String, backgroundImage: UIImage) {
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }
    
    private func setupBackButton() {
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.backItem?.title = " "
    }
}
