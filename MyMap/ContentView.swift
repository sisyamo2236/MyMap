//
//  ContentView.swift
//  MyMap
//
//  Created by tanaka  on 2021/05/03.
//

import SwiftUI
import MapKit

struct ContentView: View {
    
    // 入力中の文字列を保持する状態変数
    @State var inputText:String = ""
    
    // 検索キーワードを保持する状態変数
    @State var dispSearchKey:String = ""
    
    // マップの種類の最初は標準から
    @State var dispMapType:MKMapType = .standard
    
    var body: some View{
        // 垂直にレイアウト(縦方向にレイアウト)
        VStack{
            // テキストフィールド(文字入力)
            TextField("キーワードを入力してください",
                      text: $inputText , onCommit:
                        {
                // 入力が完了したので検索キーワードに設定する
                dispSearchKey = inputText
                // 検索キーワードをデバッグエリアに出力する
                print("入力したキーワード：" + dispSearchKey)
            })
            // 空白を追加
            .padding()
            
            // 奥から手前方向にレイアウト(右下基準で配置する)
            ZStack(alignment: .bottomTrailing) {
            
                // マップを表示
                MapView(searchkey: dispSearchKey, mapType:dispMapType)
                
                // マップ種類切り替えボタン
                Button(action: {
                    // mapTypeプロパティー値をトグル
                    // 標準 → 航空写真 → 航空写真+標準
                    // → 3D Flyover → 3D Flyover+標準
                    // → 交通機関
                    if dispMapType == .standard {
                        dispMapType = .satellite
                    } else if dispMapType == .satellite {
                        dispMapType = .hybrid
                    } else if dispMapType == .hybrid {
                        dispMapType = .satelliteFlyover
                    } else if dispMapType == .satelliteFlyover {
                        dispMapType = .hybridFlyover
                    } else if dispMapType == .hybridFlyover {
                        dispMapType = .mutedStandard
                    } else {
                        dispMapType = .standard
                    }
                
                }) {
                   // マップアイコン表示
                    Image(systemName: "map")
                        .resizable()
                        .frame(width: 35.0,
                               height: 35.0,
                               alignment: .leading)
                }// Button ここまで
                // 右の余白を20空ける
                .padding(.trailing, 20.0)
                
                // 下の余白を30を空ける
                .padding(.bottom, 30.0)
            }// ZStack ここまで
            
            
            
        }// VStack ここまで
    }// body ここまで
}// ContentView ここまで


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
