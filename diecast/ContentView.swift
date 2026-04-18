//
//  ContentView.swift
//  diecast
//
//  Created by Andrew Powell on 16.04.26.
//

import SwiftUI

struct ContentView: View {
    
    @State private var DisplayResult:String = "0"
    @State private var Side:Int = 1;
    @State private var Reset:Int = 1;
    @State private var LeftValue:String = "";
    @State private var RightValue:String = "";
    @State private var RollResult:Int = 0;
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                   Text(DisplayResult)
                    .padding()
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .lineLimit(1)
                    .minimumScaleFactor(0.2)
                VStack {
                    HStack {
                        btnQuick(4)
                        btnQuick(6)
                    }
                    HStack {
                        btnQuick(8)
                        btnQuick(10)
                    }
                    HStack {
                        btnQuick(12)
                        btnQuick(20)
                    }
                    HStack {
                        btnQuick(100)
                        btnClear
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
                        btnZero
                        btnD
                        btnRoll
                    }
                    Spacer()
                    HStack {
                        NavigationLink(destination: D10View()) {
                            Text("D10")
                                .font(.title)
                                .frame(maxWidth: .infinity, maxHeight: 50)
                                .lineLimit(1)
                                .minimumScaleFactor(0.2)
                        }
                        .buttonStyle(.borderedProminent)
                        .tint(.secondary)
                    }
                }
            }
            .padding()
            .background(.black)
        }
    }
    
    private func RollDice(DieType: Int) {
        RollResult = Int.random(in: 1...DieType)
        DisplayResult = String(RollResult)
    }
    
    private func btnQuick(_ digit: Int) -> some View {
        Button(action: { RollDice(DieType: digit) }) {
            Text("1d" + String(digit))
                .font(.title)
                .frame(maxWidth: .infinity, maxHeight: 50)
                .lineLimit(1)
                .minimumScaleFactor(0.2)
        }
        .buttonStyle(.borderedProminent)
        .tint(.secondary)
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
        DisplayResult = "0";
    }
    
    private func SetRight(ButtonValue: Int) {
        if (RightValue == "") {
            RightValue = RightValue + String(ButtonValue);
            DisplayResult = LeftValue + "d" + RightValue;
        }
        else if (RightValue.count < 3) {
            RightValue = RightValue + String(ButtonValue);
            DisplayResult = LeftValue + "d" + RightValue;
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
            DisplayResult = LeftValue;
        }
        else if (LeftValue.count < 3) {
            LeftValue = LeftValue + String(ButtonValue);
            DisplayResult = LeftValue;
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
        Button(action: { AddValueToSide(ButtonValue: digit)}) {
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
            DisplayResult = LeftValue + "d";
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
            DisplayResult = String(RollResult);
            Side = 1;
            Reset = 1;
        }
    }
}
