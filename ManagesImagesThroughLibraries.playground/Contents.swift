import SwiftUI
import Kingfisher

struct ImageManagerView: View {
    let imageURL = URL(string: "https://picsum.photos/400")!

    var body: some View {
        VStack(spacing: 20) {
            KFImage(imageURL)
                .placeholder {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                        .frame(width: 100, height: 100)
                }
                .cancelOnDisappear(true)
                .fade(duration: 0.3) // animated transition
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 250, height: 250)
                .onSuccess { result in
                    print("✅ Loaded from: \(result.cacheType)") // .memory, .disk, or .none
                }
                .onFailure { error in
                    print("❌ Error loading image: \(error)")
                }

            Text("Image loaded & cached with Kingfisher")
                .font(.caption)
        }
        .padding()
    }
}
