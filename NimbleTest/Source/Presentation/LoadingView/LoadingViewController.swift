import SwiftUI

public final class LoadingViewController: UIHostingController<LoadingView> {
    init() {
        super.init(rootView: LoadingView())
        rootView.dismiss = dismiss
    }
    
    @MainActor required dynamic init?(coder aDecoder: NSCoder) { nil }
    
    func dismiss() {
        dismiss(animated: true, completion: nil)
    }
}

