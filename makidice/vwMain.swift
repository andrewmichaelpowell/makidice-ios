//  Maki Dice
//  github.com/andrewmichaelpowell

import SwiftUI

struct vwMain: View {
    
    @State private var valResult:String = "0"
    @State private var Side:Int = 1;
    @State private var Reset:Int = 1;
    @State private var LeftValue:String = "";
    @State private var RightValue:String = "";
    @State private var RollResult:Int = 0;
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                   Text(valResult)
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .lineLimit(1)
                    .minimumScaleFactor(0.2)
                VStack {
                    HStack {
                        btnQuick(4)
                        btnQuick(8)
                        btnQuick(6)
                    }
                    HStack {
                        btnQuick(10)
                        btnQuick(12)
                        btnQuick(20)
                    }
                    HStack {
                        btnQuick(100)
                        btnClear
                        NavigationLink(destination: vwD10()) {
                            Text("D10")
                                .font(.title)
                                .frame(maxWidth: .infinity, maxHeight: 50)
                                .lineLimit(1)
                                .minimumScaleFactor(0.2)
                        }
                        .buttonStyle(.borderedProminent)
                        .tint(.teal)
                    }
                }
                .padding(.vertical)
                VStack {
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
                        btnZero
                        btnD
                        btnRoll
                    }
                }
            }
            .padding(.horizontal)
            .background(.black)
            .preferredColorScheme(.dark)
        }
    }
    
    private func btnQuick(_ digit: Int) -> some View {
        Button(action: {QuickRoll(DieType: digit)}) {
            Text("1d" + String(digit))
                .font(.title)
                .frame(maxWidth: .infinity, maxHeight: 50)
                .lineLimit(1)
                .minimumScaleFactor(0.2)
        }
        .buttonStyle(.borderedProminent)
        .tint(.secondary)
    }
    
    private func QuickRoll(DieType: Int) {
        RollResult = Int.random(in: 1...DieType);
        valResult = "";
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.1) {
            valResult = String(RollResult);
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
        .tint(.orange)
    }

    private func btnClear_Click() {
        Side = 1;
        LeftValue = "";
        RightValue = "";
        valResult = "";
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.1) {
            valResult = "0";
        }
    }
    
    private func SetRight(ButtonValue: Int) {
        if (RightValue == "") {
            RightValue = RightValue + String(ButtonValue);
            valResult = LeftValue + "d" + RightValue;
        }
        else if (RightValue.count < 3) {
            RightValue = RightValue + String(ButtonValue);
            valResult = LeftValue + "d" + RightValue;
        }
    }

    private func SetLeft(ButtonValue: Int) {
        if (Reset == 1) {
            LeftValue = "";
            RightValue = "";
            Reset = 0;
        }
        if (LeftValue == "") {
            LeftValue = LeftValue + String(ButtonValue);
            valResult = LeftValue;
        }
        else if (LeftValue.count < 3) {
            LeftValue = LeftValue + String(ButtonValue);
            valResult = LeftValue;
        }
    }
    
    private func AddValueToSide (ButtonValue: Int) {
        if (Side == 1) {
            SetLeft(ButtonValue: ButtonValue);
        }
        if (Side == 2) {
            SetRight(ButtonValue: ButtonValue);
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
        .tint(.secondary)
    }
    
    private var btnZero: some View {
        Button(action: btnZero_Click) {
            Text("0")
                .font(.title)
                .frame(maxWidth: .infinity, maxHeight: 50)
                .lineLimit(1)
                .minimumScaleFactor(0.2)
        }
        .buttonStyle(.borderedProminent)
        .tint(.secondary)
    }
    
    private func btnZero_Click() {
        if (Side == 1) {
            if ((LeftValue != "") && (Reset == 0)) {
                AddValueToSide(ButtonValue: 0);
            }
        }
        if (Side == 2) {
            if ((RightValue != "") && (Reset == 0)) {
                AddValueToSide(ButtonValue: 0);
            }
        }
    }
    
    private var btnD: some View {
        Button(action: btnD_Click) {
            Text("d")
                .font(.title)
                .frame(maxWidth: .infinity, maxHeight: 50)
                .lineLimit(1)
                .minimumScaleFactor(0.2)
        }
        .buttonStyle(.borderedProminent)
        .tint(.orange)
    }
    
    private func btnD_Click() {
        if ((Side == 1) && (Reset == 0)) {
            Side = 2;
            valResult = LeftValue + "d";
        }
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
        .tint(.orange)
    }
    
    private func btnRoll_Click() {
        if ((LeftValue != "") && (RightValue != "")) {
            RollResult = 0;
            for _ in 1...Int(LeftValue)! {
                RollResult = RollResult + Int.random(in: 1...Int(RightValue)!);
            }
            valResult = "";
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.1) {
                valResult = String(RollResult);
            }
            Side = 1;
            Reset = 1;
        }
    }
}
