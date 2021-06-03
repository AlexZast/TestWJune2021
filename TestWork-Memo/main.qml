import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import QtQml 2.0

import CMod 1.0

Window {
    width: 800
    height: 640
    visible: true
    title: qsTr("Memo Game")
    minimumHeight : 480
    minimumWidth : 640

    // Окно выбора уровней
    LevelChange{
        id: _levelChange

    }
    NewModel{
        id:models

        onFlipBack: {
            models.modelReset()
        }
        onEndGame: {
            stackV.pop(null)
        }
    }

    MainGame{
        id: gamea
    }

    StackView{
        id: stackV
        anchors.centerIn: parent
        anchors.fill: parent

        initialItem: Page {
            id:mainp
            //anchors.centerIn: parent
            BorderImage {
                id: name
                anchors.fill: parent
                anchors.centerIn: parent
                source: "qrc:/img/border.png"
            }
            BorderImage {
                anchors.fill: parent
                anchors.centerIn: parent
                source: "qrc:/img/menu_bkgmenu.png"
            }

            MyBtn{
                id: button1
                anchors.centerIn: parent
                text: "Играть"
                onClicked: {
                    stackV.push(_levelChange)
                    }
            }

            MyBtn{
                id: button2
                text: "Выйти"
                anchors.left: button1.left
                anchors.top: button1.bottom
                anchors.topMargin:  30
                onClicked: {
                    close()
                }
            }

//            Для отладки
//            MyBtn{
//                id: button3
//                text: "Проверка"
//                anchors.left: button2.left
//                anchors.top: button2.bottom
//                anchors.topMargin:  30
//                onClicked: {
//                    console.log("print")
//                    //model: NewModel
//                    models.setSize(8)
//                    models.modelReset()
//                }
//            }
//            GridView{
//                height: 4 * 100
//                width: 2 * 100
//                clip: true
//                model: models
//                delegate: Card{
//                   source: model.picture
//                   visible: model.visible
//                }

        }
    }
}
