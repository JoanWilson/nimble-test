import SwiftUI

public final class SurveyListViewController: UIViewController {
    private var contentView = SurveyListView()
    private var titleView = UIHostingController(rootView: TitleView(dayTitle: "Today", descriptiveTitle: "MONDAY, JUNE 15", userPicture: UIImage(named: "Images/userPic")!))
    
    public override func loadView() {
        super.loadView()
        
        view = contentView
        titleView.view.backgroundColor = .clear
        navigationItem.titleView = titleView.view
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
        contentView.addGestureRecognizer(panGesture)
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        title = "Test"
    }
    
    @objc func handlePan(_ gesture: UIPanGestureRecognizer) {
        if gesture.state == .ended {
            let translation = gesture.translation(in: self.view)
            if translation.x > 0 {
               print("A")
            } else {
                print("b")
            }
        }
    }
}
