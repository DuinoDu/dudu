import QtQuick 2.0

Rectangle {
    id: root

    property string text: "Message"


    width: 300; height: 100
    radius: 10
    color: "lightgray"

    Text {
        anchors.centerIn: parent
        text: root.text
        style: Text.Normal
        font.pixelSize: 19
        font.family: "Microsoft YaHei"
    }
}
