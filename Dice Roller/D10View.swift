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
            ScrollView {
                VStack(spacing: 10) {
                    Spacer()
                    HStack(spacing: 10) {
                        Text("Die Pool: " + String(DiePool))
                            .font(.largeTitle)
                            .foregroundColor(.white)
                        Spacer()
                    }
                    HStack(spacing: 10) {
                        Text("Difficulty: " + String(Difficulty))
                            .font(.largeTitle)
                            .foregroundColor(.white)
                        Spacer()
                    }
                    HStack(spacing: 10) {
                        Text("Successes: " + String(DisplayResult))
                            .font(.largeTitle)
                            .foregroundColor(.white)
                        Spacer()
                    }
                    Spacer()
                    HStack(spacing: 10) {
                        btnNumber(1)
                        btnNumber(2)
                        btnNumber(3)
                    }
                    HStack(spacing: 10) {
                        btnNumber(4)
                        btnNumber(5)
                        btnNumber(6)
                    }
                    HStack(spacing: 10) {
                        btnNumber(7)
                        btnNumber(8)
                        btnNumber(9)
                    }
                    HStack(spacing: 10) {
                        btnNumber(10)
                        btnClear
                        btnRoll
                    }
                    Spacer()
                    HStack(spacing: 10) {
                        btnDiePool
                        btnDifficulty
                    }
                }
                .padding()
            }
            .background(.black)
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
        .tint(.gray)
    }
    
    private var btnDiePool: some View {
        Button(action: btnDiePool_Click) {
            Text("Die Pool")
                .font(.title)
                .frame(maxWidth: .infinity, maxHeight: 50)
        }
        .buttonStyle(.borderedProminent)
        .tint(.orange)
    }

    
    private func btnDiePool_Click() {
        Side = 1;
    }

    private var btnDifficulty: some View {
        Button(action: btnDifficulty_Click) {
            Text("Difficulty")
                .font(.title)
                .frame(maxWidth: .infinity, maxHeight: 50)
        }
        .buttonStyle(.borderedProminent)
        .tint(.orange)
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
