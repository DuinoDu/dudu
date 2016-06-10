import QtQuick 2.0
import QtQuick.Controls 1.3
import "ui/"

Rectangle{
    id: root

    signal saveClicked(string name, string phone, string money, string password, string finger1, string finger2)

    signal createFinger()

    property string fingerID1: ""
    property string fingerID2: ""
    property int flag: 0 // 1 is for fingerID1 and 2 is for fingerID2
    onFingerID1Changed: root.updateState()
    onFingerID2Changed: root.updateState()

    property int state: 0

    width: 800
    height: 500
    color: "#dddddd"


    Image{
        anchors.fill: parent
        fillMode: Image.PreserveAspectCrop
        source: "./img/bg10.jpg"
    }

    Image{
        x: 77
        y: 53
        width: 45
        height: 45
        anchors.horizontalCenterOffset: -108
        anchors.horizontalCenter: parent.horizontalCenter
        source: "./img/username.png"
    }

    Image{
        x: 77
        y: 110
        width: 24
        height: 45
        anchors.horizontalCenterOffset: -108
        anchors.horizontalCenter: parent.horizontalCenter
        source: "./img/phone.png"
    }

    Image{
        x: 66
        y: 170
        width: 45
        height: 45
        anchors.horizontalCenterOffset: -108
        anchors.horizontalCenter: parent.horizontalCenter
        source: "./img/money.png"
    }

    Image{
        x: 66
        y: 230
        width: 45
        height: 45
        anchors.horizontalCenterOffset: -108
        anchors.horizontalCenter: parent.horizontalCenter
        source: "./img/password.png"
    }

    Image{
        id: finger1
        x: 178
        y: 318
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
            enabled: (root.fingerID1==="" && root.state >=4) ? true : false
            hoverEnabled: true
            onEntered: {
                finger1.width *= 1.2;
                finger1.height *= 1.2;
            }
            onExited: {
                finger1.width /= 1.2;
                finger1.height /= 1.2;
            }
            onClicked: {
                root.flag = 1;
                root.createFinger();
            }
        }
    }

    Image{
        id: finger2
        x: 100
        y: 318
        width: 45
        height: 45
        anchors.horizontalCenterOffset: -50
        anchors.horizontalCenter: parent.horizontalCenter
        source: root.fingerID2 === "" ? "./img/finger_off.png" : "./img/finger_on.png"

        MouseArea{
            anchors.horizontalCenterOffset: 0
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.left: parent.left
            anchors.bottom: parent.bottom
            anchors.top: parent.top
            hoverEnabled: true
            enabled: (root.fingerID2==="" && root.state >=4)? true : false
            onEntered: {
                finger2.width *= 1.2;
                finger2.height *= 1.2;
            }
            onExited: {
                finger2.width /= 1.2;
                finger2.height /= 1.2;
            }
            onClicked: {
                root.flag = 2;
                root.createFinger();
            }
        }
    }


    Input_DD{
        id: textInput_name
        x: 350
        y: 50
        anchors.horizontalCenterOffset: 27
        anchors.horizontalCenter: parent.horizontalCenter
        placeholderText: "姓名"
        re: "[^\u0000-\u00FF]" // 中文
        onInputCorrectChanged: root.updateState()
    }

    Input_DD {
        id: textInput_phone
        x: 139
        y: 110
        anchors.horizontalCenterOffset: 27
        anchors.horizontalCenter: parent.horizontalCenter
        placeholderText: "电话号码"
        re: "^1\\d{10}$"
        onInputCorrectChanged: root.updateState()
    }

    Input_DD {
        id: textInput_money
        x: 139
        y: 170
        anchors.horizontalCenterOffset: 27
        anchors.horizontalCenter: parent.horizontalCenter
        placeholderText: "充值金额"
        re: "[^\d.]"
        onInputCorrectChanged: root.updateState()
    }

    Input_DD {
        id: textInput_password
        x: 139
        y: 230
        anchors.horizontalCenterOffset: 27
        anchors.horizontalCenter: parent.horizontalCenter
        placeholderText: "密码"
        echoMode: TextInput.Password
        re: "^\\d{6}$"
        onInputCorrectChanged: root.updateState()
    }

    Button_DD{
        id: button_ok
        x: 249
        y: 408
        text: qsTr("确  定")
        anchors.horizontalCenterOffset: -80
        anchors.horizontalCenter: parent.horizontalCenter
        width: 115; height: 40
        radius: 20
        border.color: "#80C342"
        fontColor: "#80C342"
        fontSize: 18
        fontFamily: "SimSun"
        enabled: (root.state >= 6)
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
        text: qsTr("取  消")
        anchors.top: button_ok.top
        anchors.topMargin: 0
        anchors.left: button_ok.right
        anchors.leftMargin: 40
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
            root.state = 0;
        }
    }


    Image{
        y: 53
        width: 45
        height: 45
        anchors.horizontalCenterOffset: 167
        anchors.horizontalCenter: parent.horizontalCenter
        source: textInput_name.inputCorrect ? "./img/ok.png" : ""
    }

    Image {
        x: 8
        y: 110
        width: 45
        height: 45
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.horizontalCenterOffset: 167
        source: textInput_phone.inputCorrect ? "./img/ok.png" : ""
    }

    Image {
        x: -4
        y: 170
        width: 45
        height: 45
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.horizontalCenterOffset: 167
        source: textInput_money.inputCorrect ? "./img/ok.png" : ""
    }

    Image {
        x: -4
        y: 233
        width: 45
        height: 45
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.horizontalCenterOffset: 167
        source: textInput_password.inputCorrect ? "./img/ok.png" : ""
    }

    function updateState(){
        var count = 0;
        if(textInput_name.inputCorrect) count += 1;
        if(textInput_phone.inputCorrect) count += 1;
        if(textInput_money.inputCorrect) count += 1;
        if(textInput_password.inputCorrect) count += 1;
        if(root.fingerID1!== "") count += 1;
        if(root.fingerID2!== "") count += 1;
        root.state = count;
    }
}
