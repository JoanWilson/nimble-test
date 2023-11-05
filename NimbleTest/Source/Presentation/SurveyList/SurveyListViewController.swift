import UIKit

public final class SurveyListViewController: UIViewController {
    private var contentView = SurveyListView()
    
    public override func loadView() {
        super.loadView()
        view = contentView
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        title = "Test"
    }
}
