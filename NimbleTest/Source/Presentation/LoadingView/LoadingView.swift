import SwiftUI
import ShimmerView

public struct LoadingView: View {
    @State private var isAnimating: Bool = true
    
    var dismiss: (() -> Void)?
    
    public var body: some View {
        ShimmerScope(isAnimating: $isAnimating) {
            VStack(alignment: .leading) {
                HStack {
                    VStack(alignment: .leading, spacing: 13) {
                        LoadingBar(width: 117)
                        LoadingBar(width: 100)
                    }
                    
                    Spacer()
                    
                    ShimmerElement(width: 36, height: 36)
                        .background(.gray)
                        .cornerRadius(17)
                        .opacity(0.2)
                }
                
                Spacer()
                
                VStack(alignment: .leading) {
                    LoadingBar(width: 40)
                        .padding(.bottom, 5)
                    LoadingBar(width: 250)
                    LoadingBar(width: 130)
                        .padding(.bottom, 5)
                    LoadingBar(width: .infinity)
                        .padding(.trailing, 20)
                    LoadingBar(width: 200)
                }
            }
        }
        .padding()
        .background(Color("Colors/loadingBackground"))
        
    }
}

struct LoadingBar: View {
    @State var width: Double
    
    var body: some View {
        ShimmerElement(width: width, height: 17)
            .background(.gray)
            .cornerRadius(10)
            .opacity(0.2)
    }
}

#Preview {
    LoadingView()
}
