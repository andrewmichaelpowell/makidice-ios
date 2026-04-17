import SwiftUI

struct D10View: View {
    
    @State private var DisplayResult:Int = 0;
    @State private var DiePool:Int = 0;
    @State private var Difficulty:Int = 0;
    @State private var Successes:Int = 0;
    @State private var Side:Int = 1;
    @State private var RollResult:Int = 0;
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                HStack {
                    lblDiePool
                    Text(String(DiePool))
                        .font(.largeTitle)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .lineLimit(1)
                        .minimumScaleFactor(0.2)
                }
                .padding()
                HStack {
                    lblDifficulty
                    Text(String(Difficulty))
                        .font(.largeTitle)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .lineLimit(1)
                        .minimumScaleFactor(0.2)
                }
                .padding()
                HStack {
                    Text("Successes")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .lineLimit(1)
                        .minimumScaleFactor(0.2)
                    Text(String(DisplayResult))
                        .font(.largeTitle)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .lineLimit(1)
                        .minimumScaleFactor(0.2)
                }
                .padding()
                VStack {
                    Spacer()
                    HStack {
                        btnDiePool
                        btnDifficulty
                    }

                    Spacer()
                    HStack {
                        btnNumber(1)
                        btnNumber(2)
                        btnNumber(3)
                    }
                    HStack {
                        btnNumber(4)
                        btnNumber(5)
                        btnNumber(6)
                    }
                    HStack {
                        btnNumber(7)
                        btnNumber(8)
                        btnNumber(9)
                    }
                    HStack {
                        btnNumber(10)
                        btnClear
                        btnRoll
                    }
                }
                .padding()
            }
            .background(.black)
        }
    }
    
    private var lblDiePool: some View {
        if (Side == 1) {
            Text("Die Pool")
                .font(.largeTitle)
                .foregroundColor(.orange)
                .frame(maxWidth: .infinity, alignment: .leading)
                .lineLimit(1)
                .minimumScaleFactor(0.2)

        }
        else {
            Text("Die Pool")
                .font(.largeTitle)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, alignment: .leading)
                .lineLimit(1)
                .minimumScaleFactor(0.2)

        }
    }

    private var lblDifficulty: some View {
        if (Side == 2) {
            Text("Difficulty")
                .font(.largeTitle)
                .foregroundColor(.orange)
                .frame(maxWidth: .infinity, alignment: .leading)
                .lineLimit(1)
                .minimumScaleFactor(0.2)

        }
        else {
            Text("Difficulty")
                .font(.largeTitle)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, alignment: .leading)
                .lineLimit(1)
                .minimumScaleFactor(0.2)

        }
    }

    
    private var btnClear: some View {
        Button(action: btnClear_Click) {
            Text("Clear")
                .font(.title)
                .frame(maxWidth: .infinity, maxHeight: 50)
        }
        .buttonStyle(.borderedProminent)
        .tint(.orange)
    }

    private func btnClear_Click() {
        Side = 1;
        DisplayResult = 0;
        DiePool = 0;
        Difficulty = 0;
        Successes = 0;
    }
        
    private func AddValueToSide (ButtonValue: Int) {
        if (Side == 1) {
            DiePool = ButtonValue;
        }
        if (Side == 2) {
            Difficulty = ButtonValue;
        }
    }
    
    private func btnNumber(_ digit: Int) -> some View {
        Button(action: { AddValueToSide(ButtonValue: digit)}) {
            Text(String(digit))
                .font(.title)
                .frame(maxWidth: .infinity, maxHeight: 50)
        }
        .buttonStyle(.borderedProminent)
        .tint(.secondary)
    }
    
    private var btnDiePool: some View {
        if (Side == 1) {
            Button(action: btnDiePool_Click) {
                Text("Die Pool")
                    .font(.title)
                    .frame(maxWidth: .infinity, maxHeight: 50)
            }
            .buttonStyle(.borderedProminent)
            .tint(.orange)
        }
        else {
            Button(action: btnDiePool_Click) {
                Text("Die Pool")
                    .font(.title)
                    .frame(maxWidth: .infinity, maxHeight: 50)
            }
            .buttonStyle(.borderedProminent)
            .tint(.secondary)
        }
    }

    private func btnDiePool_Click() {
        Side = 1;
    }

    private var btnDifficulty: some View {
        if (Side == 2) {
            Button(action: btnDifficulty_Click) {
                Text("Difficulty")
                    .font(.title)
                    .frame(maxWidth: .infinity, maxHeight: 50)
            }
            .buttonStyle(.borderedProminent)
            .tint(.orange)
        }
        else {
            Button(action: btnDifficulty_Click) {
                Text("Difficulty")
                    .font(.title)
                    .frame(maxWidth: .infinity, maxHeight: 50)
            }
            .buttonStyle(.borderedProminent)
            .tint(.secondary)

        }
    }

    private func btnDifficulty_Click() {
        Side = 2;
    }
        
    private var btnRoll: some View {
        Button(action: btnRoll_Click) {
            Text("Roll")
                .font(.title)
                .frame(maxWidth: .infinity, maxHeight: 50)
        }
        .buttonStyle(.borderedProminent)
        .tint(.orange)
    }
    
    private func btnRoll_Click() {
        if ((DiePool != 0) && (Difficulty != 0)) {
            Successes = 0;
            for _ in 1...DiePool {
                RollResult = Int.random(in: 1...10);
                if (RollResult == 1) {
                    Successes = Successes - 1;
                }
                else if (RollResult == 10) {
                    Successes = Successes + 2;
                }
                else if (RollResult >= Difficulty) {
                    Successes = Successes + 1;
                }
            }
            DisplayResult = Successes;
        }
    }
}
