import SwiftUI

// Model
struct Bet: Identifiable, Codable {
    let id = UUID()
    let title: String
    let url: String
}

struct BettingSite: Identifiable, Codable {
    let id = UUID()
    let name: String
    let logoUrl: String
    let bets: [Bet]
}

// ViewModel
class BettingViewModel: ObservableObject {
    @Published var sites: [BettingSite] = []
    
    init() {
        fetchBets()
    }
    
    func fetchBets() {
        // Example static data. Replace with your API fetching code.
        guard let url = URL(string: "https://yourbackend.com/api/top-bets") else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    let sites = try JSONDecoder().decode([BettingSite].self, from: data)
                    DispatchQueue.main.async {
                        self.sites = sites
                    }
                } catch {
                    print("Decoding error:", error)
                }
            }
        }.resume()
    }
}

// SwiftUI View
struct ContentView: View {
    @StateObject var viewModel = BettingViewModel()
    
    var body: some View {
        NavigationView {
            List(viewModel.sites) { site in
                Section(header: HStack {
                    AsyncImage(url: URL(string: site.logoUrl)) { image in
                        image.resizable()
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(width: 40, height: 40)
                    Text(site.name)
                        .font(.headline)
                }) {
                    ForEach(site.bets) { bet in
                        Button(action: {
                            if let url = URL(string: bet.url) {
                                UIApplication.shared.open(url)
                            }
                        }) {
                            Text(bet.title)
                        }
                    }
                }
            }
            .navigationTitle("Top Bets")
        }
    }
}
