import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import CMod 1.0


Page{

    BorderImage {
        id: name
        anchors.centerIn: parent
        anchors.fill: parent
        source: "qrc:/img/border.png"
    }

    Text{
        anchors.centerIn: parent
        width: parent
        anchors.fill: parent
        anchors.topMargin: 20
        horizontalAlignment: Text.AlignHCenter


            text: "Всего набрано очков: " + models.point + ". Осталось пар: " + (models.m_size/2 - models.point) + " из " + (models.m_size/2)
            font.family: "Helvetica"
            font.pointSize: width / 40
            color: "black"
        }

    GridView{
        id: maingrid
        anchors.centerIn: parent
        height: 300
        width: 400

        model: models
        delegate: Card {
            source: model.picture
            visible: model.visible
        }
    }

    Image {
        id: exit
        source: "qrc:/img/close.png"

        width: 60
        height: 60

        anchors.right: parent.right
        anchors.top: parent.top
        anchors.topMargin: 20
        anchors.rightMargin: 20

        MouseArea{
            anchors.fill: parent
            onClicked: {
                stackV.pop(null)
            }
        }
    }
}
