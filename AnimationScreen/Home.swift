//
//  Home.swift
//  AnimationScreen
//
//  Created by Maxim Macari on 17/3/21.
//

import SwiftUI

struct Home: View {
    
    @State var offset: [CGSize] = Array(repeating: .zero, count: 3)
    
    @State var timer = Timer.publish(every: 4, on: .current, in: .common).autoconnect()
    
    @State var delayTime: Double = 0
    
    
    var locations: [CGSize] = [
        //rotation 1
        CGSize(width: 110, height: 0),
        CGSize(width: 0, height: -110),
        CGSize(width: -110, height: 0),
        //rotation 2
        CGSize(width: 110, height: 110),
        CGSize(width: 110, height: -110),
        CGSize(width: -110, height: -110),
        //rotation 3
        CGSize(width: 0, height: 110),
        CGSize(width: 110, height: 0),
        CGSize(width: 0, height: -110),
        // final resetting
        CGSize(width: 0, height: 0),
        CGSize(width: 0, height: 0),
        CGSize(width: 0, height: 0)
    ]
    
    var body: some View {
        ZStack{
            Color.pink
                .ignoresSafeArea()
            
            //Loader view
            VStack(spacing: 10){
                HStack(spacing: 10){
                    
                    Rectangle()
                        .fill(Color.blue)
                        .frame(width: 100, height: 100)
                        .offset(offset[0])
                    
                }
                .frame(width: 210, alignment: .leading)
                
                HStack(spacing: 10){
                    
                    Rectangle()
                        .fill(Color.yellow)
                        .frame(width: 100, height: 100)
                        .offset(offset[1])
                    
                    Rectangle()
                        .fill(Color.green)
                        .frame(width: 100, height: 100)
                        .offset(offset[2])
                    
                    
                }
                
            }
        }
        .onAppear(){
            setPositions()
        }
        .onReceive(timer, perform: { _ in
            print("redo ANimation")
            delayTime = 0
            setPositions()
        })
    }
    
    func setPositions() {
        var tempOffsets: [[CGSize]] = []
        
        var currentSet: [CGSize] = []
        
        for value in locations{
            currentSet.append(value)
            
            if currentSet.count == 3 {
                tempOffsets.append(currentSet)
                
                currentSet.removeAll()
            }
        }
        
        if !currentSet.isEmpty {
            tempOffsets.append(currentSet)
            currentSet.removeAll()
        }
        
        //Animation
        for offset in tempOffsets {
            for index in offset.indices {
                //each box shift will take 0.5  sec to finish
                //so delay will be 0.3 and its multiplies
                doAnimation(delay: .now() + delayTime, value: offset[index], index: index)
                delayTime += 0.3
            }
        }
    }
    
    func doAnimation(delay: DispatchTime, value: CGSize, index: Int) {
        DispatchQueue.main.asyncAfter(deadline: delay) {
            withAnimation(Animation.easeInOut(duration: 0.5)) {
                self.offset[index] = value
            }
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}


