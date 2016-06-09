import QtQuick 2.0
import QtQuick.Controls 1.3
import "ui/"

Rectangle{
    id: root

    signal saveClicked(string name, string phone, string money, string password, string finger1, string finger2)

    signal createFinger(int flag)

    property string fingerID1: ""
    property string fingerID2: ""

    width: 800
    height: 500

    Image{
        x: 287
        y: 38
        width: 45
        height: 45
        anchors.horizontalCenterOffset: -108
        anchors.horizontalCenter: parent.horizontalCenter
        source: "./img/username1.png"
    }

    Image{
        x: 77
        y: 100
        width: 24
        height: 45
        anchors.horizontalCenterOffset: -108
        anchors.horizontalCenter: parent.horizontalCenter
        source: "./img/phone.png"
    }

    Image{
        x: 66
        y: 160
        width: 45
        height: 45
        anchors.horizontalCenterOffset: -108
        anchors.horizontalCenter: parent.horizontalCenter
        source: "./img/money.png"
    }

    Image{
        x: 66
        y: 220
        width: 45
        height: 45
        anchors.horizontalCenterOffset: -108
        anchors.horizontalCenter: parent.horizontalCenter
        source: "./img/password.png"
    }

    Image{
        id: finger1
        x: 178
        y: 303
        width: 45
        height: 45
        anchors.horizontalCenterOffset: 50
        anchors.horizontalCenter: parent.horizontalCenter
        source: root.fingerID1 === "" ? "./img/finger_off.png" : "./img/finger_on.png"

        MouseArea{
            anchors.horizontalCenterOffset: 0
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.left: parent.left
            anchors.bottom: parent.bottom
            anchors.top: parent.top
            enabled: root.fingerID1==="" ? true : false
            hoverEnabled: true
            onEntered: {
                finger1.width *= 1.2;
                finger1.height *= 1.2;
            }
            onExited: {
                finger1.width /= 1.2;
                finger1.height /= 1.2;
            }
            onClicked: root.createFinger(0)
        }
    }

    Image{
        id: finger2
        x: 100
        y: 303
        width: 45
        height: 45
        anchors.horizontalCenterOffset: -50
        anchors.horizontalCenter: parent.horizontalCenter
        source: root.fingerID2 === "" ? "./img/finger\_off.png" : "./img/finger_on.png"

        MouseArea{
            anchors.horizontalCenterOffset: 0
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.left: parent.left
            anchors.bottom: parent.bottom
            anchors.top: parent.top
            hoverEnabled: true
            enabled: root.fingerID2==="" ? true : false
            onEntered: {
                finger2.width *= 1.2;
                finger2.height *= 1.2;
            }
            onExited: {
                finger2.width /= 1.2;
                finger2.height /= 1.2;
            }
            onClicked: root.createFinger(1)
        }
    }


    Input_DD{
        id: textInput_name
        x: 350
        y: 35
        anchors.horizontalCenterOffset: 27
        anchors.horizontalCenter: parent.horizontalCenter
        placeholderText: "姓名"
        re: "[^\u0000-\u00FF]" // 中文
    }

    Input_DD {
        id: textInput_phone
        x: 139
        y: 100
        anchors.horizontalCenterOffset: 27
        anchors.horizontalCenter: parent.horizontalCenter
        placeholderText: "电话号码"
        re: "^1\\d{10}$"
    }

    Input_DD {
        id: textInput_money
        x: 139
        y: 160
        anchors.horizontalCenterOffset: 27
        anchors.horizontalCenter: parent.horizontalCenter
        placeholderText: "充值金额"
        re: "[^\d.]"
    }

    Input_DD {
        id: textInput_password
        x: 139
        y: 220
        anchors.horizontalCenterOffset: 27
        anchors.horizontalCenter: parent.horizontalCenter
        placeholderText: "密码"
        echoMode: TextInput.Password
        re: "^\\d{6}$"
    }

    Button_DD{
        id: button_ok
        x: 66
        y: 373
        text: qsTr("确  定")
        anchors.horizontalCenterOffset: -80
        anchors.horizontalCenter: parent.horizontalCenter
        width: 115; height: 40
        radius: 20
        border.color: "#80C342"
        fontColor: "#80C342"
        fontSize: 18
        fontFamily: "SimSun"
        onClicked: {
            root.saveClicked(
                        textInput_name.text,
                        textInput_phone.text,
                        textInput_money.text,
                        textInput_password.text,
                        root.fingerID1,
                        root.fingerID2);
        }
    }

    Button_DD{
        id: button_cancel
        x: 224
        y: 373
        text: qsTr("取  消")
        anchors.horizontalCenterOffset: 80
        anchors.horizontalCenter: parent.horizontalCenter
        width: 115; height: 40
        radius: 20
        border.color: "#80C342"
        fontColor: "#80C342"
        fontSize: 18
        fontFamily: "SimSun"
        onClicked: {
            textInput_name.text = "";
            textInput_phone.text = "";
            textInput_money.text = "";
            textInput_password.text = "";
            root.fingerID1 = "";
            root.fingerID2 = "";
        }
    }


    Image{
        y: 38
        width: 45
        height: 45
        anchors.horizontalCenterOffset: 167
        anchors.horizontalCenter: parent.horizontalCenter
        source: textInput_name.inputCorrect ? "./img/ok.png" : ""
    }

    Image {
        x: 8
        y: 100
        width: 45
        height: 45
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.horizontalCenterOffset: 167
        source: textInput_phone.inputCorrect ? "./img/ok.png" : ""
    }

    Image {
        x: -4
        y: 160
        width: 45
        height: 45
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.horizontalCenterOffset: 167
        source: textInput_money.inputCorrect ? "./img/ok.png" : ""
    }

    Image {
        x: -4
        y: 223
        width: 45
        height: 45
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.horizontalCenterOffset: 167
        source: textInput_password.inputCorrect ? "./img/ok.png" : ""
    }

}
