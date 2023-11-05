import SwiftUI

struct TitleView: View {
    @State var dayTitle: String
    @State var descriptiveTitle: String
    @State var userPicture: UIImage
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(descriptiveTitle)
                .font(.system(size: 13, weight: .semibold))
            HStack {
                Text(dayTitle)
                    .font(.system(size: 34, weight: .bold))
                Spacer()
                VStack {
                    Image(uiImage: userPicture)
                        .resizable()
                        .frame(width: 36, height: 36)
                }
            }
        }.padding(.top, 50)
    }
}
