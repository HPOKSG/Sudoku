/*
 RMIT University Vietnam
 Course: COSC2659 iOS Development
 Semester: 2023B
 Assessment: Assignment 2
 Author: Dinh Gia Huu Phuoc
 ID: s3878270
 Created  date: 25/08/2023
 Last modified: 06/09/2023
 Acknowledgement: COSC2659 Lecture Slides, Apple IOS Development Tutorial
 */

import SwiftUI

struct HowToPlayView: View {
    @EnvironmentObject var soundStorage :SoundDataStorage
    var body: some View {
        
        ScrollView {
            VStack(spacing:30) {
                VStack (alignment: .leading){
                    Text( soundStorage.language ? "Sudoku Rule No 1: Use Numbers 1-9" : "Luật Sudoku số 1: Sử dụng các số từ 1 đến 9.")
                        .bold()
                        .font(.title2)
                        .padding(.bottom)
                    
                    Text(soundStorage.language ? firstRule : firstRuleViet)
                        .bold()
                        .font(.title3)
                }
                .padding(.all)
                .background{
                    RoundedRectangle(cornerRadius: 15)
                        .fill(Color("itemStat"))
                }
                
                
                VStack (alignment: .leading){
                    Text(soundStorage.language ? "Sudoku Rule No 2: Don’t Repeat Any Numbers" : "Luật Sudoku số 2: Không Lặp Lại Bất Kỳ Số Nào.")
                        .bold()
                        .font(.title2)
                        .padding(.bottom)
                    
                    Text(soundStorage.language ? secondRule : secondRuleViet)
                        .bold()
                        .font(.title3)
                }
                .padding(.all)
                .background{
                    RoundedRectangle(cornerRadius: 15)
                        .fill(Color("itemStat"))
                }
                
                
                VStack (alignment: .leading){
                    Text(soundStorage.language ? "Sudoku Rule No 3: Don't Guess" : "Luật Sudoku số 3: Đừng Đoán.")
                        .bold()
                        .font(.title2)
                        .padding(.bottom)
                    
                    Text(soundStorage.language ? thirdRule : thirdRuleViet)
                        .bold()
                        .font(.title3)
                }
                .padding(.all)
                .background{
                    RoundedRectangle(cornerRadius: 15)
                        .fill(Color("itemStat"))
                }
            }
        }
        .padding(.all)
       
    }
}

struct HowToPlayView_Previews: PreviewProvider {
    static var previews: some View {
        HowToPlayView()
            .environmentObject(SoundDataStorage())
    }
}
var firstRule = "Sudoku is played on a grid of 9 x 9 spaces. Within the rows and columns are 9 “squares” (made up of 3 x 3 spaces). Each row, column and square (9 spaces each) needs to be filled out with the numbers 1-9, without repeating any numbers within the row, column or square. Does it sound complicated? As you can see from the image below of an actual Sudoku grid, each Sudoku grid comes with a few spaces already filled in; the more spaces filled in, the easier the game – the more difficult Sudoku puzzles have very few spaces that are already filled in."

var firstRuleViet = "Sudoku được chơi trên một lưới 9 x 9 ô vuông. Trong các hàng và cột có 9 'hình vuông' (gồm 3 x 3 ô vuông). Mỗi hàng, cột và hình vuông (9 ô vuông mỗi cái) cần được điền bằng các số từ 1 đến 9, mà không được lặp lại bất kỳ số nào trong hàng, cột hoặc hình vuông nào. Nghe có vẻ phức tạp không? Như bạn có thể thấy từ hình ảnh dưới đây của một lưới Sudoku thực tế, mỗi lưới Sudoku đi kèm với một số ô vuông đã được điền sẵn; càng nhiều ô vuông đã điền sẵn, trò chơi càng dễ - các câu đố Sudoku khó thì có rất ít ô vuông đã được điền sẵn."

var secondRule = "As you can see, in the upper left square (circled in blue), this square already has 7 out of the 9 spaces filled in. The only numbers missing from the square are 5 and 6. By seeing which numbers are missing from each square, row, or column, we can use process of elimination and deductive reasoning to decide which numbers need to go in each blank space. For example, in the upper left square, we know we need to add a 5 and a 6 to be able to complete the square, but based on the neighboring rows and squares we cannot clearly deduce which number to add in which space. This means that we should ignore the upper left square for now, and try to fill in spaces in some other areas of the grid instead."

var secondRuleViet = "Như bạn có thể thấy, trong ô vuông ở góc trên bên trái (được khoanh tròn bằng màu xanh), ô vuông này đã có 7 trên tổng số 9 ô vuông đã được điền sẵn. Các số duy nhất thiếu trong ô vuông này là 5 và 6. Bằng cách xác định những số nào thiếu trong mỗi ô vuông, hàng hoặc cột, chúng ta có thể sử dụng phương pháp loại trừ và lý thuyết suy diễn để quyết định các số cần điền vào từng ô trống. Ví dụ, trong ô vuông góc trên bên trái, chúng ta biết chúng ta cần thêm số 5 và 6 để hoàn thành ô vuông này, nhưng dựa trên các hàng và ô vuông lân cận, chúng ta không thể rõ ràng suy luận được số nào phải được thêm vào ô nào. Điều này có nghĩa là chúng ta nên tạm thời bỏ qua ô vuông góc trên bên trái và thử điền các số vào các ô ở những khu vực khác của lưới."


var thirdRule = "Sudoku is a game of logic and reasoning, so you shouldn’t have to guess. If you don’t know what number to put in a certain space, keep scanning the other areas of the grid until you seen an opportunity to place a number. But don’t try to “force” anything – Sudoku rewards patience, insights, and recognition of patterns, not blind luck or guessing."

var thirdRuleViet = "Sudoku là một trò chơi dựa trên logic và lý thuyết, vì vậy bạn không nên phải đoán. Nếu bạn không biết phải điền số gì vào một ô cụ thể, hãy tiếp tục quét các khu vực khác của lưới cho đến khi bạn thấy cơ hội để điền số. Nhưng đừng cố gắng ép bất kỳ điều gì - Sudoku đánh giá cao sự kiên nhẫn, sự hiểu biết và nhận biết mẫu, không phải may mắn mù quáng hoặc đoán."
