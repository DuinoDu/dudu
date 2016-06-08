import QtQuick 2.0
import QtQuick.Controls 1.3
import "ui/"

Rectangle{
    id: root

    signal saveClicked(string name, string phone, string money, string password, string finger1, string finger2)

    width: 400
    height: 400

    Text {
        id: text1
        x: 69
        y: 65
        text: qsTr("姓名")
        font.pixelSize: 12
    }

    Text {
        id: text2
        x: 63
        y: 101
        text: qsTr("手机号")
        font.pixelSize: 12
    }

    Text {
        id: text3
        x: 57
        y: 139
        width: 48
        height: 16
        text: qsTr("初始金额")
        font.pixelSize: 12
    }

    Text {
        id: text4
        x: 57
        y: 232
        text: qsTr("指纹状态")
        font.pixelSize: 12
    }

    Input_DD{
        id: textInput_name
        x: 132
        y: 56
        text: qsTr("dd")
    }


    Input_DD {
        id: textInput_phone
        x: 132
        y: 92
        text: qsTr("12812345678")
    }

    Input_DD {
        id: textInput_money
        x: 132
        y: 132

        text: qsTr("100.0")
    }

    Button {
        id: button_createFinger
        x: 192
        y: 226
        text: qsTr("创建指纹信息")
    }

    Button {
        id: button_ok
        x: 57
        y: 293
        text: qsTr("确定")
        onClicked: {
            root.saveClicked(
                        textInput_name.text,
                        textInput_phone.text,
                        textInput_money.text,
                        textInput_password.text,
                        label_finger1.text,
                        label_finger2.text);
        }
    }

    Button {
        id: button_cancel
        x: 177
        y: 293
        text: qsTr("取消")
    }

    Label {
        id: label_finger1
        x: 139
        y: 231
        text: qsTr("1")
    }

    Label {
        id: label_finger2
        x: 150
        y: 231
        text: qsTr("2")
    }

    Text {
        id: text5
        x: 57
        y: 184
        width: 48
        height: 16
        text: qsTr("密码")
        font.pixelSize: 12
    }

    Input_DD {
        id: textInput_password
        x: 132
        y: 177
        text: qsTr("123456")
        inputType: 1
    }
}
