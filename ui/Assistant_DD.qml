import QtQuick 2.0

Image{
    id: image1
    width: 80
    height: 80

    property string text: "message"

    source: "qrc:/img/message.png"
    Text{
        y: 25
        text: parent.text
        anchors.verticalCenterOffset: -10
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenterOffset: 0
        anchors.horizontalCenter: parent.horizontalCenter
        color: "white"
        font.pixelSize: 16
    }
}
