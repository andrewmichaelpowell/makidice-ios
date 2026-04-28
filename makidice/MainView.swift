//  Maki Dice
//  github.com/andrewmichaelpowell

import SwiftUI

struct MainView: View {
    
    @State private var ResultString:String = "0"
    @State private var ResultValue:Int = 0
    @State private var Side:Int = 1
    @State private var Reset:Int = 1
    @State private var LeftValue:String = ""
    @State private var RightValue:String = ""
    
    let Color1 = Color(red: 36/255.0, green: 36/255.0, blue: 40/255.0, opacity: 1.0)
    let Color2 = Color(red: 255/255.0, green: 146/255.0, blue: 48/255.0, opacity: 1.0)
    let Color3 = Color(red: 2/255.0, green: 211/255.0, blue: 223/255.0, opacity: 1.0)
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                   Text(ResultString)
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .lineLimit(1)
                    .minimumScaleFactor(0.2)
                VStack {
                    HStack {
                        QuickButton(4)
                        QuickButton(6)
                        QuickButton(8)
                    }
                    HStack {
                        QuickButton(10)
                        QuickButton(12)
                        QuickButton(20)
                    }
                    HStack {
                        ClearButton
                        QuickButton(100)
                        NavigationLink(destination: D10View()) {
                            Text("D10")
                                .font(.title)
                                .frame(maxWidth: .infinity, maxHeight: 50)
                                .lineLimit(1)
                                .minimumScaleFactor(0.2)
                        }
                        .buttonStyle(.borderedProminent)
                        .tint(Color3)
                    }
                }
                .padding(.vertical)
                VStack {
                    HStack {
                        NumberButton(1)
                        NumberButton(2)
                        NumberButton(3)
                    }
                    HStack {
                        NumberButton(4)
                        NumberButton(5)
                        NumberButton(6)
                    }
                    HStack {
                        NumberButton(7)
                        NumberButton(8)
                        NumberButton(9)
                    }
                    HStack {
                        DButton
                        ZeroButton
                        RollButton
                    }
                }
            }
            .padding(.horizontal)
            .background(.black)
            .preferredColorScheme(.dark)
        }
    }
    
    private func QuickButton(_ digit: Int) -> some View {
        Button(action: {QuickRoll(DieType: digit)}) {
            Text("1d" + String(digit))
                .font(.title)
                .frame(maxWidth: .infinity, maxHeight: 50)
                .lineLimit(1)
                .minimumScaleFactor(0.2)
        }
        .buttonStyle(.borderedProminent)
        .tint(Color1)
    }
    
    private func QuickRoll(DieType: Int) {
        ResultValue = Int.random(in: 1...DieType)
        ResultString = ""
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.1) {
            ResultString = String(ResultValue)
        }
    }
    
    private var ClearButton: some View {
        Button(action: ClearButton_Click) {
            Text("Clear")
                .font(.title)
                .frame(maxWidth: .infinity, maxHeight: 50)
                .lineLimit(1)
                .minimumScaleFactor(0.2)
        }
        .buttonStyle(.borderedProminent)
        .tint(Color2)
    }

    private func ClearButton_Click() {
        Side = 1
        LeftValue = ""
        RightValue = ""
        ResultString = ""
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.1) {
            ResultString = "0"
        }
    }
    
    private func SetRight(ButtonValue: Int) {
        if (RightValue == "") {
            RightValue = RightValue + String(ButtonValue)
            ResultString = LeftValue + "d" + RightValue
        }
        else if (RightValue.count < 3) {
            RightValue = RightValue + String(ButtonValue)
            ResultString = LeftValue + "d" + RightValue
        }
    }

    private func SetLeft(ButtonValue: Int) {
        if (Reset == 1) {
            LeftValue = ""
            RightValue = ""
            Reset = 0
        }
        if (LeftValue == "") {
            LeftValue = LeftValue + String(ButtonValue)
            ResultString = LeftValue
        }
        else if (LeftValue.count < 3) {
            LeftValue = LeftValue + String(ButtonValue)
            ResultString = LeftValue
        }
    }
    
    private func AddValueToSide (ButtonValue: Int) {
        if (Side == 1) {
            SetLeft(ButtonValue: ButtonValue)
        }
        if (Side == 2) {
            SetRight(ButtonValue: ButtonValue)
        }
    }
    
    private func NumberButton(_ digit: Int) -> some View {
        Button(action: {AddValueToSide(ButtonValue: digit)}) {
            Text(String(digit))
                .font(.title)
                .frame(maxWidth: .infinity, maxHeight: 50)
                .lineLimit(1)
                .minimumScaleFactor(0.2)
        }
        .buttonStyle(.borderedProminent)
        .tint(Color1)
    }
    
    private var ZeroButton: some View {
        Button(action: ZeroButton_Click) {
            Text("0")
                .font(.title)
                .frame(maxWidth: .infinity, maxHeight: 50)
                .lineLimit(1)
                .minimumScaleFactor(0.2)
        }
        .buttonStyle(.borderedProminent)
        .tint(Color1)
    }
    
    private func ZeroButton_Click() {
        if (Side == 1) {
            if ((LeftValue != "") && (Reset == 0)) {
                AddValueToSide(ButtonValue: 0)
            }
        }
        if (Side == 2) {
            if ((RightValue != "") && (Reset == 0)) {
                AddValueToSide(ButtonValue: 0)
            }
        }
    }
    
    private var DButton: some View {
        Button(action: DButton_Click) {
            Text("d")
                .font(.title)
                .frame(maxWidth: .infinity, maxHeight: 50)
                .lineLimit(1)
                .minimumScaleFactor(0.2)
        }
        .buttonStyle(.borderedProminent)
        .tint(Color2)
    }
    
    private func DButton_Click() {
        if ((Side == 1) && (Reset == 0)) {
            Side = 2
            ResultString = LeftValue + "d"
        }
    }
    
    private var RollButton: some View {
        Button(action: RollButton_Click) {
            Text("Roll")
                .font(.title)
                .frame(maxWidth: .infinity, maxHeight: 50)
                .lineLimit(1)
                .minimumScaleFactor(0.2)
        }
        .buttonStyle(.borderedProminent)
        .tint(Color2)
    }
    
    private func RollButton_Click() {
        if ((LeftValue != "") && (RightValue != "")) {
            ResultValue = 0
            for _ in 1...Int(LeftValue)! {
                ResultValue = ResultValue + Int.random(in: 1...Int(RightValue)!)
            }
            ResultString = ""
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.1) {
                ResultString = String(ResultValue)
            }
            Side = 1
            Reset = 1
        }
    }
}
