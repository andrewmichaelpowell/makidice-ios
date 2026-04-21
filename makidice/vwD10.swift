//  Maki Dice
//  github.com/andrewmichaelpowell

import SwiftUI

struct vwD10: View {
    
    @State private var valDice:String = "0";
    @State private var valDifficulty:String = "0";
    @State private var valSuccesses:String = "0";
    @State private var Dice:Int = 0;
    @State private var Difficulty:Int = 0;
    @State private var Successes:Int = 0;
    @State private var Side:Int = 1;
    @State private var RollResult:Int = 0;
    
    let clr1 = Color(red: 36/255.0, green: 36/255.0, blue: 40/255.0, opacity: 1.0)
    let clr2 = Color(red: 248/255.0, green: 149/255.0, blue: 64/255.0, opacity: 1.0)
    let clr3 = Color(red: 67/255.0, green: 208/255.0, blue: 222/255.0, opacity: 1.0)

    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                HStack {
                    lblDice
                    Text(valDice)
                        .font(.largeTitle)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .lineLimit(1)
                        .minimumScaleFactor(0.2)
                }
                .padding(.horizontal)
                HStack {
                    lblDifficulty
                    Text(valDifficulty)
                        .font(.largeTitle)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .lineLimit(1)
                        .minimumScaleFactor(0.2)
                }
                .padding(.horizontal)
                HStack {
                    Text("Successes")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .lineLimit(1)
                        .minimumScaleFactor(0.2)
                    Text(valSuccesses)
                        .font(.largeTitle)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .lineLimit(1)
                        .minimumScaleFactor(0.2)
                }
                .padding(.horizontal)
                    HStack {
                        btnDice
                        btnDifficulty
                    }
                    .padding()
                    HStack {
                        btnNumber(1)
                        btnNumber(2)
                        btnNumber(3)
                    }
                    .padding(.horizontal)
                    HStack {
                        btnNumber(4)
                        btnNumber(5)
                        btnNumber(6)
                    }
                    .padding(.horizontal)
                    HStack {
                        btnNumber(7)
                        btnNumber(8)
                        btnNumber(9)
                    }
                    .padding(.horizontal)
                HStack {
                        btnNumber(10)
                        btnClear
                        btnRoll
                    }
                    .padding(.horizontal)
            }
            .background(.black)
            .preferredColorScheme(.dark)
        }
    }
    
    private var lblDice: some View {
        if (Side == 1) {
            Text("Dice")
                .font(.largeTitle)
                .foregroundColor(clr3)
                .frame(maxWidth: .infinity, alignment: .leading)
                .lineLimit(1)
                .minimumScaleFactor(0.2)

        }
        else {
            Text("Dice")
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
                .foregroundColor(clr3)
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
                .lineLimit(1)
                .minimumScaleFactor(0.2)
        }
        .buttonStyle(.borderedProminent)
        .tint(clr2)
    }

    private func btnClear_Click() {
        Dice = 0;
        Difficulty = 0;
        Successes = 0;
        valDice = "";
        valDifficulty = "";
        valSuccesses = "";
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.1) {
            valDice = "0";
            valDifficulty = "0";
            valSuccesses = "0";
        }
    }
        
    private func AddValueToSide (ButtonValue: Int) {
        if (Side == 1) {
            Dice = ButtonValue;
            valDice = (String(Dice));
        }
        if (Side == 2) {
            Difficulty = ButtonValue;
            valDifficulty = (String(Difficulty));
        }
    }
    
    private func btnNumber(_ digit: Int) -> some View {
        Button(action: {AddValueToSide(ButtonValue: digit)}) {
            Text(String(digit))
                .font(.title)
                .frame(maxWidth: .infinity, maxHeight: 50)
                .lineLimit(1)
                .minimumScaleFactor(0.2)
        }
        .buttonStyle(.borderedProminent)
        .tint(clr1)
    }
    
    private var btnDice: some View {
        if (Side == 1) {
            Button(action: btnDice_Click) {
                Text("Dice")
                    .font(.title)
                    .frame(maxWidth: .infinity, maxHeight: 50)
                    .lineLimit(1)
                    .minimumScaleFactor(0.2)
            }
            .buttonStyle(.borderedProminent)
            .tint(clr3)
        }
        else {
            Button(action: btnDice_Click) {
                Text("Dice")
                    .font(.title)
                    .frame(maxWidth: .infinity, maxHeight: 50)
                    .lineLimit(1)
                    .minimumScaleFactor(0.2)
            }
            .buttonStyle(.borderedProminent)
            .tint(clr1)
        }
    }

    private func btnDice_Click() {
        Side = 1;
    }

    private var btnDifficulty: some View {
        if (Side == 2) {
            Button(action: btnDifficulty_Click) {
                Text("Difficulty")
                    .font(.title)
                    .frame(maxWidth: .infinity, maxHeight: 50)
                    .lineLimit(1)
                    .minimumScaleFactor(0.2)
            }
            .buttonStyle(.borderedProminent)
            .tint(clr3)
        }
        else {
            Button(action: btnDifficulty_Click) {
                Text("Difficulty")
                    .font(.title)
                    .frame(maxWidth: .infinity, maxHeight: 50)
                    .lineLimit(1)
                    .minimumScaleFactor(0.2)
            }
            .buttonStyle(.borderedProminent)
            .tint(clr1)
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
                .lineLimit(1)
                .minimumScaleFactor(0.2)
        }
        .buttonStyle(.borderedProminent)
        .tint(clr2)
    }
    
    private func btnRoll_Click() {
        if ((Dice != 0) && (Difficulty != 0)) {
            Successes = 0;
            for _ in 1...Dice {
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
            valSuccesses = "";
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.1) {
                valSuccesses = String(Successes);
            }
        }
    }
}
