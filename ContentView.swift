import SwiftUI

struct Bet: Identifiable {
    let id = UUID()
    let description: String
    let odds: String
}

enum Sport: String, CaseIterable, Identifiable {
    case MLB, NFL, NBA, NHL
    var id: String { self.rawValue }
}

struct Provider: Identifiable {
    let id = UUID()
    let name: String
    let betsBySport: [Sport: [Bet]]
}
// Bets are us AI helped with the format
class BettingViewModel: ObservableObject {
    @Published var providers: [Provider] = [
        Provider(name: "Draft Kings", betsBySport: [
            .MLB: [
                Bet(description: "Aaron Judge to hit a home run", odds: "-100"),
                Bet(description: "Mike Trout to get 2+ hits", odds: "+300"),
                Bet(description: "Cubs VS Pirates run(s) in first inning", odds: "YES or NO"),
                Bet(description: "Pete Crow Armstrong 0.5 Stolen Bases", odds: "OVER -100, UNDER +100"),
                Bet(description: "Kyle Tucker to sign extension with Cubs before free agency", odds: "+500")
            ],
            .NFL: [
                Bet(description: "Saquon Barkely O/U 1.5 RTDS", odds: "OVER +100, UNDER +200"),
                Bet(description: "Derrick Henry to rush 100+ yards", odds: "+340"),
                Bet(description: "Tyreek Hill to hit free agency", odds: "+150"),
                Bet(description: "Travis Kelce to catch 8+ passes", odds: "+35"),
                Bet(description: "Aaron Donald to record 2 sacks", odds: "+250"),
                Bet(description: "Ashton Jeanty to be a bust", odds: "+ 500")
            ],
            .NBA: [
                Bet(description: "LeBron James to score 30+ points", odds: "+0"),
                Bet(description: "Stephen Curry to hit 5+ threes", odds: "+0"),
                Bet(description: "Jokic to get a triple-double", odds: "+0"),
                Bet(description: "Luka Doncic to score 25+ points", odds: "+0"),
                Bet(description: "Tatum to grab 10+ rebounds", odds: "+0")
            ],
            .NHL: [
                Bet(description: "Connor McDavid to score", odds: "+0"),
                Bet(description: "Ovechkin to take 5+ shots", odds: "+0"),
                Bet(description: "Crosby to assist", odds: "+0"),
                Bet(description: "Shesterkin to make 30+ saves", odds: "+0"),
                Bet(description: "Matthews to score 2 goals", odds: "+0")
            ]
        ]),
        
        Provider(name: "ESPN Bet", betsBySport: [
            .MLB: [
                Bet(description: "Pete Alonso to record 4+ TB", odds: "+250"),
                Bet(description: "Manny Machado to get 3 RBIs", odds: "+600"),
                Bet(description: "Yordan Alvarez to record over2 walks", odds: "+700"),
                Bet(description: "Bo Bichette O/U 0.5 RBI(s)", odds: "+210"),
                Bet(description: "Wander Franco to come back to baseball", odds: "+10000")
            ],
            .NFL: [
                Bet(description: "Saquon Barkely O/U 1.5 RTDS", odds: "OVER +120, UNDER +250"),
                Bet(description: "Derrick Henry to rush 100+ yards", odds: "+320"),
                Bet(description: "Tyreek Hill to hit free agency", odds: "+100"),
                Bet(description: "Travis Kelce to catch 8+ passes", odds: "+40"),
                Bet(description: "Aaron Donald to record 2 sacks", odds: "+230"),
                Bet(description: "Ashton Jeanty to be a bust", odds: "+ 250")
            ],
            .NBA: [
                Bet(description: "Ja Morant to dunk twice", odds: "+0"),
                Bet(description: "Zion Williamson to get a double-double", odds: "+0"),
                Bet(description: "Damian Lillard to score 35+", odds: "+0"),
                Bet(description: "Anthony Edwards to block 2 shots", odds: "+0"),
                Bet(description: "Jimmy Butler to steal 3 balls", odds: "+0")
            ],
            .NHL: [
                Bet(description: "Jack Hughes to score", odds: "+0"),
                Bet(description: "Kaprizov to assist", odds: "+0"),
                Bet(description: "Connor Hellebuyck to save 35+", odds: "+0"),
                Bet(description: "Mark Stone to hit twice", odds: "+0"),
                Bet(description: "Elias Pettersson to get 3 points", odds: "+0")
            ]
        ]),
        
        Provider(name: "Fanduel", betsBySport: [
            .MLB: [
                Bet(description: "Vladimir Guerrero Jr. to homer", odds: "+0"),
                Bet(description: "Matt Olson to drive in 2", odds: "+0"),
                Bet(description: "Corbin Burnes to strike out 10", odds: "+0"),
                Bet(description: "Corey Seager to get 3 hits", odds: "+0"),
                Bet(description: "Julio Rodriguez to steal 2 bases", odds: "+0")
            ],
            .NFL: [
                Bet(description: "Lamar Jackson to rush 75+ yards", odds: "+0"),
                Bet(description: "Justin Fields to throw 2+ TDs", odds: "+0"),
                Bet(description: "Stefon Diggs to catch 100+ yards", odds: "+0"),
                Bet(description: "TJ Hockenson to score", odds: "+0"),
                Bet(description: "Micah Parsons to get 2 sacks", odds: "+0")
            ],
            .NBA: [
                Bet(description: "Kevin Durant to hit 10+ FGs", odds: "+0"),
                Bet(description: "Kawhi Leonard to grab 9+ rebounds", odds: "+0"),
                Bet(description: "Paul George to hit 4+ threes", odds: "+0"),
                Bet(description: "Jaylen Brown to block 2 shots", odds: "+0"),
                Bet(description: "De'Aaron Fox to get 10 assists", odds: "+0")
            ],
            .NHL: [
                Bet(description: "Sebastian Aho to score 2 goals", odds: "+0"),
                Bet(description: "Roman Josi to assist twice", odds: "+0"),
                Bet(description: "Frederik Andersen to save 28+", odds: "+0"),
                Bet(description: "David Pastrnak to score", odds: "+0"),
                Bet(description: "Brady Tkachuk to get 4 hits", odds: "+0")
            ]
        ])
    ]
    
    func getBets(for provider: Provider, sport: Sport) -> [Bet] {
        provider.betsBySport[sport] ?? []
    }
}

struct ContentView: View {
    @StateObject var viewModel = BettingViewModel()
    @State private var selectedProvider: Provider? = nil
    @State private var selectedSport: Sport = .MLB
    
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
            .navigationTitle("Betting Apps")
            
            if let provider = selectedProvider {
                VStack(alignment: .leading, spacing: 20) {
                    Text("\(provider.name) Bets")
                        .font(.largeTitle)
                        .bold()

                    Text("Select a Sport")
                        .font(.subheadline)

                    Picker("Sport", selection: $selectedSport) {
                        ForEach(Sport.allCases) { sport in
                            Text(sport.rawValue).tag(sport)
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                    .frame(height: 150)
                    .onChange(of: selectedSport) { _ in } // triggers UI update

                    List(viewModel.getBets(for: provider, sport: selectedSport)) { bet in
                        HStack {
                            Text(bet.description)
                            Spacer()
                            Text(bet.odds)
                                .foregroundColor(.gray)
                        }
                        .padding(.vertical, 4)
                    }

                    Spacer()
                }
                .padding()
                .navigationTitle(provider.name)
            } else {
                Text("Select a Betting App")
                    .font(.title)
                    .foregroundColor(.gray)
            }
        }
    }
}
