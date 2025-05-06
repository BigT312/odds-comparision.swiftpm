import SwiftUI

struct Bet: Identifiable, Hashable {
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

class BettingViewModel: ObservableObject {
    @Published var providers: [Provider] = [
        Provider(name: "Draft Kings", betsBySport: [
            .MLB: [
                Bet(description: "Aaron Judge to hit a home run", odds: "+100"),
                Bet(description: "Mike Trout to get 2+ hits", odds: "+300"),
                Bet(description: "Cubs VS Pirates run(s) in first inning", odds: "YES +100 or NO -205"),
                Bet(description: "Pete Crow Armstrong 0.5 Stolen Bases", odds: "OVER -50, UNDER +150"),
                Bet(description: "Kyle Tucker to sign extension with Cubs before free agency", odds: "+500")
            ],
            .NFL: [
                Bet(description: "Saquon Barkley O/U 1.5 RTDS", odds: "OVER +110, UNDER +190"),
                Bet(description: "Derrick Henry to rush 100+ yards", odds: "+530"),
                Bet(description: "Tyreek Hill to hit free agency", odds: "-105"),
                Bet(description: "Travis Kelce to catch 8+ passes", odds: "+100"),
                Bet(description: "Aaron Donald to record 2 sacks", odds: "+260")
            ],
            .NBA: [
                Bet(description: "LeBron James to score 30+ points", odds: "+150"),
                Bet(description: "Stephen Curry to hit 5+ threes", odds: "-220"),
                Bet(description: "Nikola Jokic to get a triple-double", odds: "+230"),
                Bet(description: "Luka Doncic to score 25+ points", odds: "+124"),
                Bet(description: "Jayson Tatum to grab 10+ rebounds", odds: "+190")
            ],
            .NHL: [
                Bet(description: "Connor McDavid to score", odds: "+190"),
                Bet(description: "Alex Ovechkin to take 5+ shots", odds: "+110"),
                Bet(description: "Sidney Crosby to assist", odds: "+100"),
                Bet(description: "Igor Shesterkin to make 30+ saves", odds: "+350"),
                Bet(description: "Auston Matthews to score 2 goals", odds: "+555")
            ]
        ]),
        Provider(name: "ESPN Bet", betsBySport: [
            .MLB: [
                Bet(description: "Aaron Judge to hit a home run", odds: "+200"),
                Bet(description: "Mike Trout to get 2+ hits", odds: "+250"),
                Bet(description: "Cubs VS Pirates run(s) in first inning", odds: "YES +100 or NO -150"),
                Bet(description: "Pete Crow Armstrong 0.5 Stolen Bases", odds: "OVER -20, UNDER +100"),
                Bet(description: "Kyle Tucker to sign extension with Cubs before free agency", odds: "+550")
            ],
            .NFL: [
                Bet(description: "Saquon Barkley O/U 1.5 RTDS", odds: "OVER +125, UNDER -100"),
                Bet(description: "Derrick Henry to rush 100+ yards", odds: "+100"),
                Bet(description: "Tyreek Hill to hit free agency", odds: "+124"),
                Bet(description: "Travis Kelce to catch 8+ passes", odds: "+140"),
                Bet(description: "Aaron Donald to record 2 sacks", odds: "+100")
            ],
            .NBA: [
                Bet(description: "LeBron James to score 30+ points", odds: "+450"),
                Bet(description: "Stephen Curry to hit 5+ threes", odds: "-50"),
                Bet(description: "Nikola Jokic to get a triple-double", odds: "+1000"),
                Bet(description: "Luka Doncic to score 25+ points", odds: "+805"),
                Bet(description: "Jayson Tatum to grab 10+ rebounds", odds: "+560")
            ],
            .NHL: [
                Bet(description: "Connor McDavid to score", odds: "+655"),
                Bet(description: "Alex Ovechkin to take 5+ shots", odds: "+545"),
                Bet(description: "Sidney Crosby to assist", odds: "+140"),
                Bet(description: "Igor Shesterkin to make 30+ saves", odds: "+135"),
                Bet(description: "Auston Matthews to score 2 goals", odds: "+112")
            ]
        ]),
        Provider(name: "Fanduel", betsBySport: [
            .MLB: [
                Bet(description: "Aaron Judge to hit a home run", odds: "+300"),
                Bet(description: "Mike Trout to get 2+ hits", odds: "+550"),
                Bet(description: "Cubs VS Pirates run(s) in first inning", odds: "YES +150 or NO -100"),
                Bet(description: "Pete Crow Armstrong 0.5 Stolen Bases", odds: "OVER +20, UNDER +100"),
                Bet(description: "Kyle Tucker to sign extension with Cubs before free agency", odds: "+350")
            ],
            .NFL: [
                Bet(description: "Saquon Barkley O/U 1.5 RTDS", odds: "OVER +230, UNDER -210"),
                Bet(description: "Derrick Henry to rush 100+ yards", odds: "+140"),
                Bet(description: "Tyreek Hill to hit free agency", odds: "-100"),
                Bet(description: "Travis Kelce to catch 8+ passes", odds: "+230"),
                Bet(description: "Aaron Donald to record 2 sacks", odds: "+215")
            ],
            .NBA: [
                Bet(description: "LeBron James to score 30+ points", odds: "+115"),
                Bet(description: "Stephen Curry to hit 5+ threes", odds: "+155"),
                Bet(description: "Nikola Jokic to get a triple-double", odds: "+200"),
                Bet(description: "Luka Doncic to score 25+ points", odds: "+155"),
                Bet(description: "Jayson Tatum to grab 10+ rebounds", odds: "+140")
            ],
            .NHL: [
                Bet(description: "Connor McDavid to score", odds: "+145"),
                Bet(description: "Alex Ovechkin to take 5+ shots", odds: "+128"),
                Bet(description: "Sidney Crosby to assist", odds: "+125"),
                Bet(description: "Igor Shesterkin to make 30+ saves", odds: "+270"),
                Bet(description: "Auston Matthews to score 2 goals", odds: "+305")
            ]
        ])
    ]

    @Published var favoriteBets: Set<Bet> = []

    func getBets(for provider: Provider, sport: Sport) -> [Bet] {
        provider.betsBySport[sport] ?? []
    }

    func isFavorite(_ bet: Bet) -> Bool {
        favoriteBets.contains(bet)
    }

    func toggleFavorite(_ bet: Bet) {
        if favoriteBets.contains(bet) {
            favoriteBets.remove(bet)
        } else {
            favoriteBets.insert(bet)
        }
    }
}
struct ContentView: View {
    @StateObject var viewModel = BettingViewModel()
    @State private var selectedProvider: Provider? = nil
    @State private var selectedSport: Sport = .MLB
    @State private var selectedBetToCompare: Bet? = nil
    @State private var showingComparison = false

    var body: some View {
        VStack {
            if let provider = selectedProvider {
                VStack(alignment: .leading, spacing: 16) {
                    HStack {
                        Button("Back to Main Page") {
                            selectedProvider = nil
                        }
                        .padding(8)
                        .background(Color.blue.opacity(0.2))
                        .cornerRadius(8)

                        Spacer()
                    }

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
                    .pickerStyle(SegmentedPickerStyle())

                    List(viewModel.getBets(for: provider, sport: selectedSport)) { bet in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(bet.description)
                                Text(bet.odds)
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }

                            Spacer()

                            VStack {
                                Button(action: {
                                    viewModel.toggleFavorite(bet)
                                }) {
                                    Image(systemName: viewModel.isFavorite(bet) ? "star.fill" : "star")
                                        .foregroundColor(.yellow)
                                }

                                Button("Compare") {
                                    selectedBetToCompare = bet
                                    showingComparison = true
                                }
                                .font(.caption)
                                .foregroundColor(.blue)
                            }
                        }
                    }
                }
                .padding()
            } else {
                Text("Select a Betting App")
                    .font(.largeTitle)
                    .padding()

                List(viewModel.providers) { provider in
                    Button(action: {
                        selectedProvider = provider
                        selectedSport = .MLB
                    }) {
                        HStack {
                            Image(provider.nameImageName)
                                .resizable()
                                .frame(width: 40, height: 40)
                                .cornerRadius(6)
                            Text(provider.name)
                                .font(.headline)
                                .padding(.leading, 8)
                        }
                        .padding(4)
                    }
                }
            }
        }
        .sheet(isPresented: $showingComparison) {
            if let bet = selectedBetToCompare {
                VStack(alignment: .leading) {
                    Text("Compare Odds for:")
                        .font(.headline)
                    Text(bet.description)
                        .font(.subheadline)
                        .padding(.bottom)

                    List(compareBets(for: bet), id: \.provider) { entry in
                        HStack {
                            Text(entry.provider)
                            Spacer()
                            Text(entry.odds)
                                .foregroundColor(.gray)
                        }
                    }

                    Button("Close") {
                        showingComparison = false
                    }
                    .padding()
                }
                .padding()
            }
        }
    }

    func compareBets(for bet: Bet) -> [(provider: String, odds: String)] {
        viewModel.providers.compactMap { provider in
            for bets in provider.betsBySport.values {
                if let match = bets.first(where: { $0.description == bet.description }) {
                    return (provider.name, match.odds)
                }
            }
            return nil
        }
        
    }
}

extension Provider {
    var nameImageName: String {
        switch name {
        case "Draft Kings": return "Draft 2"
        case "ESPN Bet": return "Espn 2"
        case "Fanduel": return "Fan 2"
        default: return "placeholder"
        }
    }
}

