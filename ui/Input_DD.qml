import QtQuick 2.0
import QtQuick.Controls 1.3

Rectangle{
    id: root

    property string text: "input"
    property int inputType: 0
    property string inputMask: "X"

    width: 200
    height: 30

    border.color: "green"
    border.width: 2
    radius: 4

    TextInput {
        id: textInput_name
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        anchors.leftMargin: 4
        anchors.right:parent.right
        text: root.text
        font.pixelSize: 16
        selectByMouse: true
        echoMode: root.inputType === 0 ? TextInput.Normal : TextInput.Password
    }
}
