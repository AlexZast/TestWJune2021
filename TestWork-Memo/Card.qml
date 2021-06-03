import QtQuick 2.12
import QtQuick.Window 2.12


Item{
    id: card
    height: 100
    width: 100
    property alias source: bottomPic.source
    signal clicked;

    property alias flipped: flip.flipped

    Flipable { // свойство, означающее поворот объекта
        id: flip
        anchors.fill: parent
        anchors.centerIn: parent
        property bool flipped  // перевернуто ли изображение
        width: 100
        height: 100

        front: BorderImage {
        id: topPic
        source: "qrc:/img/front.png"
        width: 100; height: 100
        border.left: 0; border.top: 0
        border.right: 0; border.bottom: 0
        anchors.centerIn: parent
        }

        back: BorderImage {
            id: bottom
            source: "qrc:/img/back.png"
            width: 100; height: 100
            border.left: 0; border.top: 0
            border.right: 0; border.bottom: 0
            anchors.centerIn: parent
            BorderImage {
                id: bottomPic
                //source: "qrc:/img/front.png"
                width: 100; height: 100
                border.left: 0; border.top: 0
                border.right: 0; border.bottom: 0
                anchors.centerIn: parent
            }
        }
        transform: Rotation { // способ трансформации изображения
            id: rotation // поворот
            origin.x: 50; origin.y: 0
            axis {x: 0; y: 1; z:0} // как поворачиваем
            angle: 0 // угол
        }

        states: State { // задаем состояние
            name: "back" // название состояния
            PropertyChanges { target: rotation; angle: 180} // изменяемые параметры
            when: flip.flipped // когда переменная указывает на то, что был совершен переворот
        }

        transitions: Transition {
            NumberAnimation { target: rotation; property: "angle"; duration: 1000;} // задаем время анимации
        }

        Timer{
            id:itime
            interval: 1500; running: false; repeat: false
            onTriggered: {
                 models.checkAndDo()
                 console.log("timerStop")
            }
        }

        MouseArea {
            anchors.fill: parent
            onClicked: {
                if (model.visible === true && model.isFlip !== true && models.canFlip === true) {
                    flip.flipped = true;
                    models.moveV(model.index)
                    if(models.openCard === 2){
                       itime.start()
                    }
                }
            }
        }
    }
}



