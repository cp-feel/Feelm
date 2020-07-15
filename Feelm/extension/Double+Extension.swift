//
//  Double+Extension.swift
//  Feelm
//
//  Created by feel on 2020/07/10.
//  Copyright © 2020 ___FEEL___. All rights reserved.
//

import Foundation

extension Double {
    //00:00형태로 바꾸기 위해 timeinterval 값을 받아 문자열로 돌려보내는 함수
    public func convertTimeIntervalToString() -> String {
        //재생시간의 매개변수인 time값을 60으로 나눈 몫을 정수 값으로 변환하여 상수 min에 초기화
        let min = Int(self/60)
        //time값을 60으로 나눈 나머지 값을 정수 값으로 변환하여 상수 sec 값에 초기화 한다.
        let sec = Int(self.truncatingRemainder(dividingBy: 60))
        //이 두 값을 이용해서 "%02d:%02d" 형태의 문자열로 변환하여 상수에 초기화
        let strTime = String(format: "%02d:%02d",min,sec)
        return strTime
    }
    
    public func convertTimeIntervalToMilliSecString() -> String {
        let mSec = self < 0 ? 0: self
        let strTime = String(format: "%00.2f",mSec)
        return strTime
    }
}
