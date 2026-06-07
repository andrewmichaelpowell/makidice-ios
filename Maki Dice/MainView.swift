//  Maki Dice
//  github.com/andrewmichaelpowell

import SwiftUI

struct MainView: View
{
    
    @State private var diceNumber:String = ""
    @State private var diceType:String = ""
    @State private var editSide:Int = 1
    @State private var resetInput:Int = 1
    @State private var resultString:String = "0"
    @State private var resultValue:Int = 0
    
    let color1 = Color(red: 36/255.0, green: 36/255.0, blue: 40/255.0, opacity: 1.0)
    let color2 = Color(red: 255/255.0, green: 146/255.0, blue: 48/255.0, opacity: 1.0)
    let color3 = Color(red: 2/255.0, green: 211/255.0, blue: 223/255.0, opacity: 1.0)
    
    var body: some View
    {
        NavigationStack
        {
            VStack
            {
                Spacer()
                Text(resultString)
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .lineLimit(1)
                    .minimumScaleFactor(0.2)
                VStack
                {
                    HStack
                    {
                        quickButton(4)
                        quickButton(6)
                        quickButton(8)
                    }
                    HStack
                    {
                        quickButton(10)
                        quickButton(12)
                        quickButton(20)
                    }
                    HStack
                    {
                        clearButton
                        quickButton(100)
                        NavigationLink(destination: D10View())
                        {
                            Text("D10")
                                .font(.title)
                                .frame(maxWidth: .infinity, maxHeight: 50)
                                .lineLimit(1)
                                .minimumScaleFactor(0.2)
                        }
                        .buttonStyle(.borderedProminent)
                        .tint(color3)
                    }
                }
                .padding(.vertical)
                VStack
                {
                }
                .padding(.vertical, 4)
                VStack
                {
                    HStack
                    {
                        numberButton(1)
                        numberButton(2)
                        numberButton(3)
                    }
                    HStack
                    {
                        numberButton(4)
                        numberButton(5)
                        numberButton(6)
                    }
                    HStack
                    {
                        numberButton(7)
                        numberButton(8)
                        numberButton(9)
                    }
                    HStack
                    {
                        dButton
                        zeroButton
                        rollButton
                    }
                }
                VStack
                {
                }
                .padding(.vertical)
            }
            .padding(.horizontal)
            .background(.black)
            .preferredColorScheme(.dark)
        }
    }
    
    private func quickButton(_ digit: Int) -> some View
    {
        Button(action: {quickRoll(quickDiceType: digit)})
        {
            Text("1d" + String(digit))
                .font(.title)
                .frame(maxWidth: .infinity, maxHeight: 50)
                .lineLimit(1)
                .minimumScaleFactor(0.2)
        }
        .buttonStyle(.borderedProminent)
        .tint(color1)
    }
    
    private func quickRoll(quickDiceType: Int)
    {
        resultValue = Int.random(in: 1...quickDiceType)
        resultString = ""
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.1)
        {
            resultString = String(resultValue)
        }
    }
    
    private var clearButton: some View
    {
        Button(action: clear)
        {
            Text("Clear")
                .font(.title)
                .frame(maxWidth: .infinity, maxHeight: 50)
                .lineLimit(1)
                .minimumScaleFactor(0.2)
        }
        .buttonStyle(.borderedProminent)
        .tint(color2)
    }
    
    private func clear()
    {
        editSide = 1
        diceNumber = ""
        diceType = ""
        resultString = ""
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.1)
        {
            resultString = "0"
        }
    }
    
    private func setRight(buttonValue: Int)
    {
        if (diceType == "")
        {
            diceType = diceType + String(buttonValue)
            resultString = diceNumber + "d" + diceType
        }
        else if (diceType.count < 3)
        {
            diceType = diceType + String(buttonValue)
            resultString = diceNumber + "d" + diceType
        }
    }
    
    private func setLeft(buttonValue: Int)
    {
        if (resetInput == 1)
        {
            diceNumber = ""
            diceType = ""
            resetInput = 0
        }
        if (diceNumber == "")
        {
            diceNumber = diceNumber + String(buttonValue)
            resultString = diceNumber
        }
        else if (diceNumber.count < 3)
        {
            diceNumber = diceNumber + String(buttonValue)
            resultString = diceNumber
        }
    }
    
    private func appendDigit (buttonValue: Int)
    {
        if (editSide == 1)
        {
            setLeft(buttonValue: buttonValue)
        }
        if (editSide == 2)
        {
            setRight(buttonValue: buttonValue)
        }
    }
    
    private func numberButton(_ digit: Int) -> some View
    {
        Button(action: {appendDigit(buttonValue: digit)})
        {
            Text(String(digit))
                .font(.title)
                .frame(maxWidth: .infinity, maxHeight: 50)
                .lineLimit(1)
                .minimumScaleFactor(0.2)
        }
        .buttonStyle(.borderedProminent)
        .tint(color1)
    }
    
    private var zeroButton: some View
    {
        Button(action: zero)
        {
            Text("0")
                .font(.title)
                .frame(maxWidth: .infinity, maxHeight: 50)
                .lineLimit(1)
                .minimumScaleFactor(0.2)
        }
        .buttonStyle(.borderedProminent)
        .tint(color1)
    }
    
    private func zero()
    {
        if (editSide == 1)
        {
            if ((diceNumber != "") && (resetInput == 0))
            {
                appendDigit(buttonValue: 0)
            }
        }
        if (editSide == 2)
        {
            if ((diceType != "") && (resetInput == 0))
            {
                appendDigit(buttonValue: 0)
            }
        }
    }
    
    private var dButton: some View
    {
        Button(action: d)
        {
            Text("d")
                .font(.title)
                .frame(maxWidth: .infinity, maxHeight: 50)
                .lineLimit(1)
                .minimumScaleFactor(0.2)
        }
        .buttonStyle(.borderedProminent)
        .tint(color2)
    }
    
    private func d()
    {
        if ((editSide == 1) && (resetInput == 0))
        {
            editSide = 2
            resultString = diceNumber + "d"
        }
    }
    
    private var rollButton: some View
    {
        Button(action: roll)
        {
            Text("Roll")
                .font(.title)
                .frame(maxWidth: .infinity, maxHeight: 50)
                .lineLimit(1)
                .minimumScaleFactor(0.2)
        }
        .buttonStyle(.borderedProminent)
        .tint(color2)
    }
    
    private func roll()
    {
        if ((diceNumber != "") && (diceType != ""))
        {
            resultValue = 0
            for _ in 1...Int(diceNumber)!
            {
                resultValue = resultValue + Int.random(in: 1...Int(diceType)!)
            }
            resultString = ""
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.1)
            {
                resultString = String(resultValue)
            }
            editSide = 1
            resetInput = 1
        }
    }
}
