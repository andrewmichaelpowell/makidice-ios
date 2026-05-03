//  Maki Dice
//  github.com/andrewmichaelpowell

import SwiftUI

struct D10View: View
{
    
    @State private var DiceString:String = "0"
    @State private var DiceValue:Int = 0
    @State private var DifficultyString:String = "0"
    @State private var DifficultyValue:Int = 0
    @State private var Result:Int = 0
    @State private var Selected:Int = 1
    @State private var SuccessesString:String = "0"
    @State private var SuccessesValue:Int = 0
    
    let Color1 = Color(red: 36/255.0, green: 36/255.0, blue: 40/255.0, opacity: 1.0)
    let Color2 = Color(red: 255/255.0, green: 146/255.0, blue: 48/255.0, opacity: 1.0)
    let Color3 = Color(red: 2/255.0, green: 211/255.0, blue: 223/255.0, opacity: 1.0)

    var body: some View
    {
        NavigationStack
        {
            VStack
            {
                Spacer()
                HStack
                {
                    DiceLabel
                    Text(DiceString)
                        .font(.largeTitle)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .lineLimit(1)
                        .minimumScaleFactor(0.2)
                }
                .padding(.horizontal)
                HStack
                {
                    DifficultyLabel
                    Text(DifficultyString)
                        .font(.largeTitle)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .lineLimit(1)
                        .minimumScaleFactor(0.2)
                }
                .padding(.horizontal)
                HStack
                {
                    Text("Successes")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .lineLimit(1)
                        .minimumScaleFactor(0.2)
                    Text(SuccessesString)
                        .font(.largeTitle)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .lineLimit(1)
                        .minimumScaleFactor(0.2)
                }
                .padding(.horizontal)
                HStack
                {
                    DiceButton
                    DifficultyButton
                }
                .padding()
                VStack
                {
                }
                .padding(.vertical, 4)
                HStack
                {
                    NumberButton(1)
                    NumberButton(2)
                    NumberButton(3)
                }
                .padding(.horizontal)
                HStack
                {
                    NumberButton(4)
                    NumberButton(5)
                    NumberButton(6)
                }
                .padding(.horizontal)
                HStack
                {
                    NumberButton(7)
                    NumberButton(8)
                    NumberButton(9)
                }
                .padding(.horizontal)
                HStack
                {
                    ClearButton
                    NumberButton(10)
                    RollButton
                }
                .padding(.horizontal)
            }
            .background(.black)
            .preferredColorScheme(.dark)
        }
    }
    
    private var DiceLabel: some View
    {
        if (Selected == 1)
        {
            Text("Dice")
                .font(.largeTitle)
                .foregroundColor(Color3)
                .frame(maxWidth: .infinity, alignment: .leading)
                .lineLimit(1)
                .minimumScaleFactor(0.2)
        }
        else
        {
            Text("Dice")
                .font(.largeTitle)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, alignment: .leading)
                .lineLimit(1)
                .minimumScaleFactor(0.2)
        }
    }

    private var DifficultyLabel: some View
    {
        if (Selected == 2) {
            Text("Difficulty")
                .font(.largeTitle)
                .foregroundColor(Color3)
                .frame(maxWidth: .infinity, alignment: .leading)
                .lineLimit(1)
                .minimumScaleFactor(0.2)
        }
        else
        {
            Text("Difficulty")
                .font(.largeTitle)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, alignment: .leading)
                .lineLimit(1)
                .minimumScaleFactor(0.2)
        }
    }

    private var ClearButton: some View
    {
        Button(action: ClearButton_Click)
        {
            Text("Clear")
                .font(.title)
                .frame(maxWidth: .infinity, maxHeight: 50)
                .lineLimit(1)
                .minimumScaleFactor(0.2)
        }
        .buttonStyle(.borderedProminent)
        .tint(Color2)
    }

    private func ClearButton_Click()
    {
        DiceValue = 0
        DifficultyValue = 0
        SuccessesValue = 0
        DiceString = ""
        DifficultyString = ""
        SuccessesString = ""
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.1)
        {
            DiceString = "0"
            DifficultyString = "0"
            SuccessesString = "0"
        }
    }
        
    private func AddValueToSide (ButtonValue: Int)
    {
        if (Selected == 1)
        {
            DiceValue = ButtonValue
            DiceString = (String(DiceValue))
        }
        if (Selected == 2)
        {
            DifficultyValue = ButtonValue
            DifficultyString = (String(DifficultyValue))
        }
    }
    
    private func NumberButton(_ digit: Int) -> some View
    {
        Button(action: {AddValueToSide(ButtonValue: digit)})
        {
            Text(String(digit))
                .font(.title)
                .frame(maxWidth: .infinity, maxHeight: 50)
                .lineLimit(1)
                .minimumScaleFactor(0.2)
        }
        .buttonStyle(.borderedProminent)
        .tint(Color1)
    }
    
    private var DiceButton: some View
    {
        if (Selected == 1) {
            Button(action: DiceButton_Click)
            {
                Text("Dice")
                    .font(.title)
                    .frame(maxWidth: .infinity, maxHeight: 50)
                    .lineLimit(1)
                    .minimumScaleFactor(0.2)
            }
            .buttonStyle(.borderedProminent)
            .tint(Color3)
        }
        else
        {
            Button(action: DiceButton_Click)
            {
                Text("Dice")
                    .font(.title)
                    .frame(maxWidth: .infinity, maxHeight: 50)
                    .lineLimit(1)
                    .minimumScaleFactor(0.2)
            }
            .buttonStyle(.borderedProminent)
            .tint(Color1)
        }
    }

    private func DiceButton_Click()
    {
        Selected = 1
    }

    private var DifficultyButton: some View
    {
        if (Selected == 2)
        {
            Button(action: DifficultyButton_Click)
            {
                Text("Difficulty")
                    .font(.title)
                    .frame(maxWidth: .infinity, maxHeight: 50)
                    .lineLimit(1)
                    .minimumScaleFactor(0.2)
            }
            .buttonStyle(.borderedProminent)
            .tint(Color3)
        }
        else
        {
            Button(action: DifficultyButton_Click)
            {
                Text("Difficulty")
                    .font(.title)
                    .frame(maxWidth: .infinity, maxHeight: 50)
                    .lineLimit(1)
                    .minimumScaleFactor(0.2)
            }
            .buttonStyle(.borderedProminent)
            .tint(Color1)
        }
    }

    private func DifficultyButton_Click()
    {
        Selected = 2
    }
        
    private var RollButton: some View
    {
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
    
    private func RollButton_Click()
    {
        if ((DiceValue != 0) && (DifficultyValue != 0))
        {
            SuccessesValue = 0
            for _ in 1...DiceValue
            {
                Result = Int.random(in: 1...10)
                if (Result == 1)
                {
                    SuccessesValue = SuccessesValue - 1
                }
                else if (Result == 10)
                {
                    SuccessesValue = SuccessesValue + 2
                }
                else if (Result >= DifficultyValue)
                {
                    SuccessesValue = SuccessesValue + 1
                }
            }
            SuccessesString = ""
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.1)
            {
                SuccessesString = String(SuccessesValue)
            }
        }
    }
}
