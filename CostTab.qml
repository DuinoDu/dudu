import QtQuick 2.0
import QtQuick.Controls 1.3

Rectangle{
    id: root
    width: 400
    height: 400
    color: "#dddddd"

    Text {
        id: text1
        x: 56
        y: 56
        text: qsTr("消费金额")
        font.pixelSize: 12
    }

    Text {
        id: text2
        x: 56
        y: 118
        text: qsTr("消费者")
        font.pixelSize: 12
    }

    Text {
        id: text3
        x: 56
        y: 160
        text: qsTr("手机号")
        font.pixelSize: 12
    }

    Text {
        id: text4
        x: 56
        y: 205
        text: qsTr("账户余额")
        font.pixelSize: 12
    }

    Label {
        id: label_name
        x: 154
        y: 118
        text: qsTr("xx")
    }

    Label {
        id: label_phone
        x: 154
        y: 155
        text: qsTr("xx")
    }

    Label {
        id: label_money
        x: 154
        y: 205
        text: qsTr("xx")
    }

    TextEdit {
        id: textEdit_cost
        x: 123
        y: 56
        width: 80
        height: 16
        text: qsTr("输入消费金额")
        font.pixelSize: 12
    }

    Button {
        id: button_recognition
        x: 246
        y: 51
        text: qsTr("识别指纹")
    }

    Button {
        id: button_ok
        x: 72
        y: 294
        text: qsTr("确认消费")
    }

    Button {
        id: button_cancel
        x: 204
        y: 294
        text: qsTr("取消")
    }
}
