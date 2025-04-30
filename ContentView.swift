import SwiftUI

struct Bet: Identifiable {
    let id = UUID()
    let description: String
}

struct Sport: Identifiable {
    let id = UUID()
    let name: String
    let bets: [Bet]
}

struct Provider: Identifiable {
    let id = UUID()
    let name: String
    let sports: [Sport]
}

class BettingViewModel: ObservableObject {
    @Published var providers: [Provider] = [
        Provider(name: "Draft Kings", sports: [
            Sport(name: "MLB", bets: sampleBets),
            Sport(name: "NFL", bets: sampleBets),
            Sport(name: "NBA", bets: sampleBets),
            Sport(name: "NHL", bets: sampleBets)
        ]),
        Provider(name: "ESPN Bet", sports: [
            Sport(name: "MLB", bets: sampleBets),
            Sport(name: "NFL", bets: sampleBets),
            Sport(name: "NBA", bets: sampleBets),
            Sport(name: "NHL", bets: sampleBets)
        ]),
        Provider(name: "Fanduel", sports: [
            Sport(name: "MLB", bets: sampleBets),
            Sport(name: "NFL", bets: sampleBets),
            Sport(name: "NBA", bets: sampleBets),
            Sport(name: "NHL", bets: sampleBets)
        ])
    ]
}

let sampleBets: [Bet] = [
    Bet(description: "O/U 220.5"),
    Bet(description: "O/U 8.5"),
    Bet(description: "Spread -3.5"),
    Bet(description: "Moneyline +145"),
    Bet(description: "Total Points 210.5")
]

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
            
            if let provider = selectedProvider {
                List {
                    Section(header: Text("\(provider.name) Sports")) {
                        ForEach(provider.sports) { sport in
                            Section(header: Text(sport.name)) {
                                ForEach(sport.bets) { bet in
                                    Text(bet.description)
                                        .padding(.leading)
                                }
                            }
                        }
                    }
                }
                .navigationTitle(provider.name)
            } else {
                Text("Select a Provider")
                    .font(.title)
                    .foregroundColor(.gray)
            }
        }
    }
}
