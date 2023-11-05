import SwiftUI

public final class SurveyListViewController: UIViewController {
    private var contentView = SurveyListView()
    private var titleView = UIHostingController(rootView: TitleView(dayTitle: "Today", descriptiveTitle: "MONDAY, JUNE 15", userPicture: UIImage(named: "Images/userPic")!))
    
    public override func loadView() {
        super.loadView()
        view = contentView
        titleView.view.backgroundColor = .clear
        navigationItem.titleView = titleView.view
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        title = "Test"
    }
}
