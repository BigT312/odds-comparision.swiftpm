import SwiftUI

// Model
struct Provider: Identifiable {
    let id = UUID()
    let name: String
}

// ViewModel
class BettingViewModel: ObservableObject {
    @Published var providers: [Provider] = [
        Provider(name: "Betfair"),
        Provider(name: "Pinnacle"),
        Provider(name: "Smarkets")
    ]
}

// SwiftUI View
struct ContentView: View {
    @StateObject var viewModel = BettingViewModel()
    @State private var selectedProvider: Provider? = nil
    
    var body: some View {
        NavigationView {
            List(viewModel.providers) { provider in
                Button(action: {
                    selectedProvider = provider
                }) {
                    Text(provider.name)
                        .font(.headline)
                        .padding()
                }
            }
            .navigationTitle("Providers")
            
            // Detail View
            if let provider = selectedProvider {
                VStack(alignment: .leading, spacing: 20) {
                    Text("\(provider.name) API Info")
                        .font(.largeTitle)
                        .bold()
                    Text("Here you'll add \(provider.name)'s API information later.")
                        .font(.body)
                        .foregroundColor(.gray)
                    Spacer()
                }
                .padding()
                .navigationTitle(provider.name)
            } else {
                Text("Select a Provider")
                    .font(.title)
                    .foregroundColor(.gray)
            }
        }
    }
}
