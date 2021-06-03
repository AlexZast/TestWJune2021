import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3

BorderImage {
    signal clicked;

    property alias text: _txt.text

    source: "qrc:/img/btn_titel.png"
    width: 180; height: 42
    border.left: 5; border.top: 5
    border.right: 5; border.bottom: 5

    Text{
        id:_txt
        color: "brown"
        font.pointSize: 18
        font.family: "Monotype Corsiva"
        font.bold: true
        font.italic: true
        anchors.centerIn: parent
    }

    MouseArea{
        anchors.fill: parent
        onClicked: parent.clicked()
        onPressed: parent.source = "qrc:/img/btn_titel_prs.png"
        onReleased: parent.source = "qrc:/img/btn_titel.png"
    }

}



