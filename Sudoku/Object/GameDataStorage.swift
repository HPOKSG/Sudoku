/*
 RMIT University Vietnam
 Course: COSC2659 iOS Development
 Semester: 2023B
 Assessment: Assignment 1
 Author: Dinh Gia Huu Phuoc
 ID: s3878270
 Created  date: 25/08/2023
 Last modified: 06/09/2023
 Acknowledgement: COSC2659 Lecture Slides, Apple IOS Development Tutorial
 */

import Foundation


//initialize the game Map for different mode, each mode
//will have 5 different maps

//"006170030210009500053008000000627400827500016040810052000000870004000165100736024"
var gameMap = [
    "Easy" : [
        "600007020000000015249010003405801390380049000016070000804153602000064830160002009",
        "070305006349700800206091073032009600000038019500102004007913008900080040003000107",
        "050000004900430000000209380090070450300002000870000013501008000709310568604725039"
     
    ],
    "Medium" : [
        "000147568000050000850060000004906000000014903079000140008490025060005407005000300",
        "043005687060020010090083000000000340108049720000250000086102000000700038007000000",
        "850400000000500000000291458002043000000120036093000210008302705040050029005000060"
    ],
    "Hard":[
        "700009301100020000300080006600700005080090003000000000040050009060002050000000210",
        "085002090000000026000700000000427000300015000090000005926800300000040700403000009",
        "100009500000000000300040007000006002210900004700005001062000000003600700900003800"
    ]
]

var solutionMap = [
    "Easy" : [
        "651437928738296415249518763475821396382649157916375284894153672527964831163782549",
        "871345926349726851256891473132479685764538219598162734427913568915687342683254197",
        "253681794918437625467259381196873452345192876872546913531968247729314568684725139",
    ],
    "Medium" : [
        "923147568647853219851269734514936872286714953379528146738491625162385497495672381",
        "243915687865427913791683254629871345148349726374256891586132479912764538437598162",
        "851437692429568173376291458512643987784129536693785214968312745147856329235974861",
    ],
    "Hard":[
       "758469321196325847324187596612743985485296173973518462247851639861932754539674218",
       "124769538687532419395148267458316972216987354739425681562874193843691725971253846",
       "479685312162734958538219674913568247687342195254197863345926781726851439891473526",
       
    ]
]
