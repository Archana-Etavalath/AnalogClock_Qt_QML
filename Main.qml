import QtQuick 2.15
import QtQuick.Window 2.15

Window {
    id: id_root
    width: 400
    height: 400
    visible: true
    title: qsTr("Analog Clock")

    property date currentTime: new Date()
    property real currentHour: currentTime.getHours()%12 +(currentTime.getMinutes()/60) + (currentTime.getSeconds()/60/60)
    property real currentMinute: currentTime.getMinutes() + (currentTime.getSeconds()/60)
    property real currentSecond: currentTime.getSeconds()
    property double secondAngle: currentSecond/60*360
    property double minuteAngle: currentMinute/60*360
    property double hourAngle: currentHour/12*360

    Rectangle{
        id: id_plate
        color: "lightblue"
        anchors.centerIn: parent
        width: 400
        height: width
        radius: width
        border.color: "black"
        border.width: 5
        Repeater {
            model: 12

            Item {
                id: hourContainer

                property int hour: index
                height: id_plate.height/2
                transformOrigin: Item.Bottom
                rotation: index * 30
                x: id_plate.width/2
                y: 0
                Rectangle {
                    height: id_plate.height*0.02
                    width: height
                    radius: width/2
                    color: "black"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: parent.top
                    anchors.topMargin: 4
                    }

                    Text {
                    anchors {
                        horizontalCenter: parent.horizontalCenter
                        }
                        x: 0
                        y: id_plate.height*0.06
                        rotation: 360 - index * 30
                        text: hourContainer.hour == 0 ? 12 : hourContainer.hour
                        font.pixelSize: id_plate.height*0.1
                        font.family: "Clocko"
                    }
                }
            }
        Rectangle {
                id: id_center

                anchors.centerIn: parent
                height: id_plate.height*0.05
                width: height
                radius: width/2
                color: "black"
            }
        Item{
            id: secondItem
            width: 400
            height: 400
            rotation: secondAngle
            Rectangle{
                id: second
                color: "red"
                height: 200
                width: 2

                anchors.top: parent.top
                anchors.topMargin: 25
                x: parent.width/2 - width/2
                antialiasing: true
            }
            RotationAnimation{
                id: secondAnime
                target: secondItem
                from: secondAngle
                to:secondAngle-0.00001
                direction: RotationAnimation.Clockwise
                loops: Animation.Infinite
                duration: 60000
                running: true
            }
        }
        Item{
            id: minuteItem
            width: 400
            height: 400
            rotation: minuteAngle
            Rectangle{
                id: minute
                color: "black"
                height: 140
                width: 4
                anchors.top: parent.top
                anchors.topMargin: 55
                x: parent.width/2 - width/2
                antialiasing: true
            }
            RotationAnimation{
                id: minuteAnime
                target: minuteItem
                from: minuteAngle
                to:minuteAngle - 0.000001
                direction: RotationAnimation.Clockwise
                loops: Animation.Infinite
                duration: 60000*60
                running: true
            }
        }
        Item{
            id: hourItem
            width: 400
            height: 400
            rotation: hourAngle
            Rectangle{
                id: hour
                color: "black"
                height: 110
                width: 6
                anchors.top: parent.top
                anchors.topMargin: 85
                x: parent.width/2 - width/2
                antialiasing: true
            }
            RotationAnimation{
                id: hourAnime
                target: hourItem
                from: hourAngle
                to: hourAngle - 0.000001
                direction: RotationAnimation.Clockwise
                loops: Animation.Infinite
                duration: 60000*60*24
                running: true
            }
        }

    }

}
