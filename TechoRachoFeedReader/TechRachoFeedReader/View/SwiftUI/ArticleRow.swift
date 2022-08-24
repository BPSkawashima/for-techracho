/*
 * Copyright (c) 2022 BPS Co., Ltd.
 * All rights reserved.
 */

import SwiftUI

struct ArticleRow: View {
    @ObservedObject var viewModel: ArticleRowViewModel
    let width: CGFloat

    var body: some View {
        VStack(alignment: .leading) {
            Text(viewModel.article.title ?? "")
                .lineLimit(2)
                .font(.title)
                .padding(.top, 8)
                .padding(.horizontal, 4)
                .foregroundColor(.primary)
            HStack {
                Text(viewModel.article.authors.first ?? "")
                if viewModel.article.authors.count > 1 {
                    Text("他")
                }
                Spacer()
                Text(viewModel.article.updated?.yyyyMMdd_jp() ?? "")
            }
            .foregroundColor(.primary)
            .font(.subheadline)
            .padding(.horizontal, 4)

            Group {
                if let image = viewModel.image {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                } else {
                    Rectangle()
                        .fill(Color.gray)
                        .aspectRatio(3 / 2, contentMode: .fit)
                }
            }
            .frame(maxWidth: .infinity)

            Text(viewModel.article.summary ?? "")
                .lineLimit(3)
                .font(.subheadline)
                .foregroundColor(.gray)
                .padding(.horizontal, 4)
            categories(maxWidth: width)
        }
    }

    // See: https://reona.dev/posts/20200929
    private func categories(maxWidth: CGFloat) -> some View {
        var width = CGFloat.zero
        var height = CGFloat.zero

        return ZStack(alignment: .topLeading) {
            ForEach(viewModel.article.categories, id: \.self) { category in
                categoryItem(for: category)
                    .padding(.all, 4)
                    .alignmentGuide(.leading) { d in
                        if abs(width - d.width) > maxWidth {
                            width = 0
                            height -= d.height
                        }
                        let result = width
                        if category == viewModel.article.categories.last {
                            width = 0
                        } else {
                            width -= d.width
                        }
                        return result
                    }
                    .alignmentGuide(.top) { _ in
                        let result = height
                        if category == viewModel.article.categories.last {
                            height = 0
                        }
                        return result
                    }
            }
        }
    }

    func categoryItem(for text: String) -> some View {
        Text(text)
            .padding(.all, 5)
            .font(.footnote)
            .background(.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
    }
}

struct ArticleRow_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader { geometry in
            ArticleRow(
                viewModel: ArticleRowViewModel(article: Article(
                    title: "タイトルタイトルタイトルタイトルタイトルタイトルタイトル",
                    summary: "サマリーサマリーサマリーサマリーサマリーサマリーサマリーサマリーサマリーサマリーサマリーサマリーサマリーサマリーサマリーサマリーサマリーサマリー",
                    authors: ["田中 太郎", "あああ"],
                    links: [],
                    thumbnailImageURL: nil,
                    categories: ["AAA", "BBB", "CCC"],
                    updated: Date()
                )),
                width: geometry.size.width
            )
            .previewLayout(.fixed(width: 400, height: 120))
        }
    }
}
