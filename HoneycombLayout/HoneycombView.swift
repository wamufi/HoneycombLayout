//
//  HoneycombLayout.swift
//  HoneycombLayout
//

import SwiftUI

struct HoneycombView: View {
    let items: [String] // 아이템 목록
    
    let itemsPerOddRow: Int // 홀수 줄에 들어갈 아이템 수
    let itemsPerEvenRow: Int // 짝수 줄에 들어갈 아이템 수
    
    init(items: [String], itemsPerOddRow: Int, itemsPerEvenRow: Int) {
        self.items = items
        self.itemsPerOddRow = itemsPerOddRow
        self.itemsPerEvenRow = itemsPerEvenRow
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            ForEach(0..<numberOfRows(), id: \.self) { rowIndex in // 각 행을 생성
                HStack(spacing: 10) {
                    Spacer()
                    ForEach(itemsForRow(rowIndex), id: \.self) { item in // 특정 행에 있는 아이템을 반복하여 표시
                        Text(item)
                            .frame(width: 50, height: 50)
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(8)
                    }
                    Spacer()
                }
            }
        }
        .padding()
    }
    
    // 전체 아이템 수를 기준으로 전체 행 수를 계산
    private func numberOfRows() -> Int {
        var count = 0 // 현재까지 생성된 행의 수
        var index = 0 // 현재까지 처리된 아이템의 인덱스
        while index < items.count {
            let rowItems = itemsPerRow(row: count) // 각 행의 아이템 수 (홀수 줄 itemsPerOddRow, 짝수 줄 itemsPerEvenRow)
            index += rowItems
            count += 1
        }
        return count
    }
    
    // 각 행의 아이템 수를 결정. 홀수 줄은 itemsPerOddRow, 짝수 줄은 itemsPerEvenRow를 반환
    // row는 현재 행의 인덱스
    private func itemsPerRow(row: Int) -> Int {
        return row % 2 == 0 ? itemsPerOddRow : itemsPerEvenRow
    }
    
    // 특정 행에 해당하는 아이템. start와 end 인덱스를 계산하여 해당 행의 아이템들을 반환
    private func itemsForRow(_ rowIndex: Int) -> [String] {
        let start = (0..<rowIndex).map { itemsPerRow(row: $0) }.reduce(0, +) // 특정 행의 시작 인덱스. 이전 행까지의 모든 아이템 수를 합산하여 시작 인덱스를 계산
        let end = min(start + itemsPerRow(row: rowIndex), items.count) // 현재 행의 마지막 인덱스
        return Array(items[start..<end]) // 시작 인덱스와 끝 인덱스 사이의 아이템 배열
    }
}

#Preview {
    HoneycombView(items:Array(0...19).map { "\($0)" }, itemsPerOddRow: 4, itemsPerEvenRow: 5)
}
