//
//  ContentView.swift
//  UdemyLesson
//
//  Created by Nakanishi Toshihiko on 2021/05/05.
//

import SwiftUI

struct 構造体:Identifiable,Equatable {
    var id = UUID()
    var 構造体check:Bool
    var 構造体todo:String
    init(イニシャライザ変数check:Bool,イニシャライザ変数todo:String) {
        self.構造体check = イニシャライザ変数check
        self.構造体todo = イニシャライザ変数todo
    }
}

class クラス:ObservableObject {
    @Published var 構造体インスタンス配列 = [
        構造体(イニシャライザ変数check: true, イニシャライザ変数todo: "勉強"),
        構造体(イニシャライザ変数check: false, イニシャライザ変数todo: "散歩")
    ]
    @Published var 入力状態チェック変数:Bool = false
}

struct ContentView: View {
    @EnvironmentObject var クラスインスタンス:クラス
    var body: some View {
        NavigationView {
            List {
                ForEach(クラスインスタンス.構造体インスタンス配列) { ForEach変数 in
                    Button(action:{
                        guard let 要素番号 = クラスインスタンス.構造体インスタンス配列.firstIndex(of: ForEach変数) else {
                            return
                        }
                        self.クラスインスタンス.構造体インスタンス配列[要素番号].構造体check.toggle()
                    })
                    {
                        リスト行表示ビュー(リスト行表示ビュー変数check: ForEach変数.構造体check, リスト行表示ビュー変数todo: ForEach変数.構造体todo)
                    }
                }
                if self.クラスインスタンス.入力状態チェック変数 {
                    行追加表示ビュー()
                } else {
                    Button(action: {
                        self.クラスインスタンス.入力状態チェック変数 = true
                    })
                    {
                        Text("＋")
                        .font(.title)
                    }
                }
            }
            .navigationBarTitle(Text("ToDo"))
            .navigationBarItems(trailing: Button(action:{
                削除関数()
            })
            {
                Text("Delete")
            }
            )
        }
    }
    func 削除関数(){
        let 削除関数変数 = クラスインスタンス.構造体インスタンス配列.filter({!$0.構造体check })
        self.クラスインスタンス.構造体インスタンス配列 = 削除関数変数
    }
}

struct リスト行表示ビュー: View {
    var リスト行表示ビュー変数check:Bool
    var リスト行表示ビュー変数todo:String
    var body: some View {
        HStack {
            if リスト行表示ビュー変数check {
                Text("☑︎")
                Text(リスト行表示ビュー変数todo)
                    .strikethrough()
                    .fontWeight(.ultraLight)
            } else {
                Text("□")
                Text(リスト行表示ビュー変数todo)
            }
        }
    }
}

struct 行追加表示ビュー: View {
    @State var addListViewTodo = "" //現在propertyWrapperでは変数名に日本語を使えません
    @EnvironmentObject var クラスインスタンス: クラス
    var body: some View {
        TextField("タスクを入力してください", text:$addListViewTodo,
        onCommit: {
            self.todo作成関数()
            self.クラスインスタンス.入力状態チェック変数 = false
        })
    }
    func todo作成関数() {
        let 新しいtodo = 構造体(イニシャライザ変数check: false, イニシャライザ変数todo: addListViewTodo)
        self.クラスインスタンス.構造体インスタンス配列.insert(新しいtodo, at: 0)
        self.addListViewTodo = ""
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(クラス())
    }
}
