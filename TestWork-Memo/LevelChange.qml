import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3

import CMod 1.0

Page {
    BorderImage {
        anchors.fill: parent
        anchors.centerIn: parent
        source: "qrc:/img/border.png"
    }

    BorderImage {
        anchors.fill: parent
        anchors.centerIn: parent
        source: "qrc:/img/menu_bkg2.png"
    }

    MyBtn{
        id: button3
        text: "Легкий"
        anchors.left: button4.left
        anchors.bottom: button4.top
        anchors.bottomMargin:  30
        onClicked: {
            models.setSize(4)
            models.modelReset()
            stackV.push(gamea)
        }
    }

    MyBtn{
        id: button4
        anchors.centerIn: parent
        text: "Средний"
        anchors.bottomMargin:  30
        onClicked: {
            models.setSize(8)
            models.modelReset()
            stackV.push(gamea)
        }
    }
    MyBtn{
        id: button5
        //anchors.centerIn: parent
        text: "Тяжелый"
        anchors.left: button4.left
        anchors.top: button4.bottom
        anchors.topMargin:  30
        onClicked: {
           models.setSize(12)
           models.modelReset()
           stackV.push(gamea)
        }
    }
    MyBtn{
        id: button6
        text: "Назад"
        anchors.left: button5.left
        anchors.top: button5.bottom
        anchors.topMargin:  30
        onClicked: {
            stackV.pop()
        }
    }
}
