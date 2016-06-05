import QtQuick 2.0
import QtQuick.Controls 1.3


Rectangle{
    id: root
    width: 400
    height: 400

    Text {
        id: text1
        x: 57
        y: 56
        text: qsTr("姓名")
        font.pixelSize: 12
    }

    Text {
        id: text2
        x: 57
        y: 92
        text: qsTr("手机号")
        font.pixelSize: 12
    }

    Text {
        id: text3
        x: 57
        y: 136
        text: qsTr("初始金额")
        font.pixelSize: 12
    }

    Text {
        id: text4
        x: 57
        y: 175
        text: qsTr("指纹状态")
        font.pixelSize: 12
    }

    TextInput {
        id: textInput_name
        x: 132
        y: 56
        width: 80
        height: 20
        text: qsTr("Text Input")
        font.pixelSize: 12
    }

    TextInput {
        id: textInput2_phone
        x: 132
        y: 92
        width: 80
        height: 20
        text: qsTr("Text Input")
        font.pixelSize: 12
    }

    TextInput {
        id: textInput_money
        x: 132
        y: 132
        width: 80
        height: 20
        text: qsTr("Text Input")
        font.pixelSize: 12
    }

    Button {
        id: button_createFinger
        x: 192
        y: 170
        text: qsTr("创建指纹信息")
    }

    Button {
        id: button_ok
        x: 94
        y: 282
        text: qsTr("确定")
    }

    Button {
        id: button_cancel
        x: 223
        y: 282
        text: qsTr("取消")
    }

    Label {
        id: label1
        x: 139
        y: 175
        text: qsTr("Label")
    }
}
