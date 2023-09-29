//
//  ChartView.swift
//  SwiftUICryptoApp
//
//  Created by m.shirokova on 28.09.2023.
//

import SwiftUI

struct ChartView: View {
    
    private let data: [Double]
    private let maxY: Double
    private let minY: Double
    private let lineColor: Color
    private let startingDate: Date
    private let endingDate: Date
    @State private var percentage: CGFloat = 0.0
    
    init(coin: CoinModel) {
        self.data = coin.sparklineIn7D?.price ?? []
        self.maxY = self.data.max() ?? 0
        self.minY = self.data.min() ?? 0
        
        let priceChange = (data.last ?? 0) - (data.first ?? 0)
        lineColor = priceChange > 0 ? Color.theme.green : Color.theme.red
        
        self.startingDate = Date(coinGeckoString: coin.athDate ?? "")
        self.endingDate = Date(coinGeckoString: coin.lastUpdated ?? "")
    }
    
    var body: some View {
        VStack {
            chartView
                .frame(height: 200)
                .background(chartBackground)
                .overlay(
                    chartYAxis.padding(.horizontal, 16),
                    alignment: .leading
                )
            
            chartDateLabels
                .padding(.horizontal, 16)
        }
        .font(.caption)
        .foregroundColor(Color.theme.textColor)
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                withAnimation(.linear(duration: 2.0)) {
                    percentage = 1.0
                }
            }
        }
    }
}

struct ChartView_Previews: PreviewProvider {
    static var previews: some View {
        ChartView(coin: dev.coin)
    }
}

extension ChartView {
    
    private var chartView: some View {
        GeometryReader { geometry in
            HStack {
                Path { path in
                    for index in data.indices {
                        
                        let xPosition = geometry.size.width / CGFloat(data.count) * CGFloat(index + 1)
                        
                        let yAxis = maxY - minY
                        
                        let yPosition = (1 - CGFloat((data[index] - minY) / yAxis)) * geometry.size.height
                        
                        if index == 0 {
                            path.move(to: CGPoint(x: xPosition, y: yPosition))
                        }
                        path.addLine(to: CGPoint(x: xPosition, y: yPosition))
                    }
                }
                .trim(from: 0, to: percentage)
                .stroke(
                    lineColor,
                    style: StrokeStyle(
                        lineWidth: 1,
                        lineCap: .round,
                        lineJoin: .round
                    )
                )
                .shadow(
                    color: lineColor,
                    radius: 10,
                    x: 0.0,
                    y: 10.0
                )
                .shadow(
                    color: lineColor.opacity(0.6),
                    radius: 10,
                    x: 0.0,
                    y: 20.0
                )
                .shadow(
                    color: lineColor.opacity(0.3),
                    radius: 10,
                    x: 0.0,
                    y: 30.0
                )
                .shadow(
                    color: lineColor.opacity(0.2),
                    radius: 10,
                    x: 0.0,
                    y: 40.0
                )
            }
        }
    }
    
    private var chartBackground: some View {
        VStack {
            Divider()
                .background(Color.theme.secondaryText)
            Spacer()
            Divider()
                .background(Color.theme.secondaryText)
            Spacer()
            Divider()
                .background(Color.theme.secondaryText)
        }
    }
    
    private var chartYAxis: some View {
        VStack {
            Text(maxY.formattedWithAbbreviations())
            Spacer()
            Text(((maxY + minY) / 2).formattedWithAbbreviations())
            Spacer()
            Text(minY.formattedWithAbbreviations())
        }
    }
    
    private var chartDateLabels: some View {
        HStack {
            Text(startingDate.asShortDateString())
            Spacer()
            Text(endingDate.asShortDateString())
        }
    }
}
