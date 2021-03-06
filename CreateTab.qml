import QtQuick 2.0
import QtQuick.Controls 1.3
import "ui/"

Rectangle{
    id: root

    signal saveClicked(string name, string phone, string money, string password, string finger1, string finger2)

    signal createFinger()
    signal closePort()
    property int fingerState: 0 // 0 is to open port, 1 is to close port


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
        source: "qrc:/img/bg10.jpg"
    }

    Rectangle{
        x: 221
        y: 27
        width: 500
        height: 440
        color: "black"
        radius: 10
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        opacity: 0.4
    }

    Image{
        x: 77
        y: 53
        width: 45
        height: 45
        anchors.verticalCenter: textInput_name.verticalCenter
        anchors.horizontalCenterOffset: -140
        anchors.horizontalCenter: parent.horizontalCenter
        source: "qrc:/img/username.png"
    }

    Image{
        x: 77
        y: 110
        width: 25
        height: 45
        anchors.verticalCenterOffset: 0
        anchors.verticalCenter: textInput_phone.verticalCenter
        anchors.horizontalCenterOffset: -140
        anchors.horizontalCenter: parent.horizontalCenter
        source: "qrc:/img/phone.png"
    }

    Image{
        x: 66
        y: 170
        width: 45
        height: 45
        anchors.verticalCenterOffset: 0
        anchors.verticalCenter: textInput_money.verticalCenter
        anchors.horizontalCenterOffset: -140
        anchors.horizontalCenter: parent.horizontalCenter
        source: "qrc:/img/money.png"
    }

    Image{
        x: 66
        y: 230
        width: 45
        height: 45
        anchors.verticalCenter: textInput_password.verticalCenter
        anchors.horizontalCenterOffset: -140
        anchors.horizontalCenter: parent.horizontalCenter
        source: "qrc:/img/password.png"
    }

    Image{
        id: finger1
        x: 178
        y: 318
        width: 45
        height: 45
        anchors.verticalCenterOffset: 100
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenterOffset: 50
        anchors.horizontalCenter: parent.horizontalCenter
        source: root.fingerID1 === "" ? "qrc:/img/finger_off.png" : "qrc:/img/finger_on.png"

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
                if (root.fingerState === 0){
                    root.createFinger();
                    root.fingerState = 1;
                }else if (root.fingerState === 1){
                    root.closePort();
                    root.fingerState = 0;
                }
            }
        }
    }

    Image{
        id: finger2
        x: 100
        y: 318
        width: 45
        height: 45
        anchors.verticalCenterOffset: 100
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenterOffset: -50
        anchors.horizontalCenter: parent.horizontalCenter
        source: root.fingerID2 === "" ? "qrc:/img/finger_off.png" : "qrc:/img/finger_on.png"

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
                if (root.fingerState === 0){
                    root.createFinger();
                    root.fingerState = 1;
                }else if (root.fingerState === 1){
                    root.closePort();
                    root.fingerState = 0;
                }
            }
        }
    }


    Input_DD{
        id: textInput_name
        x: 350
        y: 50
        anchors.verticalCenterOffset: -150
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenterOffset: 0
        anchors.horizontalCenter: parent.horizontalCenter
        placeholderText: "姓名"
        re: "[^\u0000-\u00FF]" // 中文
        onInputCorrectChanged: root.updateState()
    }

    Input_DD {
        id: textInput_phone
        x: 139
        y: 110
        anchors.verticalCenterOffset: -90
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenterOffset: 0
        anchors.horizontalCenter: parent.horizontalCenter
        placeholderText: "电话号码"
        re: "^1\\d{10}$"
        onInputCorrectChanged: root.updateState()
    }

    Input_DD {
        id: textInput_money
        x: 139
        y: 170
        anchors.verticalCenterOffset: -30
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenterOffset: 0
        anchors.horizontalCenter: parent.horizontalCenter
        placeholderText: "充值金额"
        re: "[^\d.]"
        onInputCorrectChanged: root.updateState()
    }

    Input_DD {
        id: textInput_password
        x: 139
        y: 230
        anchors.verticalCenterOffset: 30
        anchors.verticalCenter: parent.verticalCenter
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
        anchors.verticalCenterOffset: 165
        anchors.verticalCenter: parent.verticalCenter
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
        anchors.verticalCenterOffset: 165
        anchors.verticalCenter: parent.verticalCenter
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
            root.state = 0;
        }
    }


    Image{
        y: 53
        width: 45
        height: 45
        anchors.verticalCenterOffset: 0
        anchors.verticalCenter: textInput_name.verticalCenter
        anchors.horizontalCenterOffset: 140
        anchors.horizontalCenter: parent.horizontalCenter
        source: textInput_name.inputCorrect ? "qrc:/img/ok.png" : ""
    }

    Image {
        x: 8
        y: 110
        width: 45
        height: 45
        anchors.verticalCenterOffset: 0
        anchors.verticalCenter: textInput_phone.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.horizontalCenterOffset: 140
        source: textInput_phone.inputCorrect ? "qrc:/img/ok.png" : ""
    }

    Image {
        x: -4
        y: 170
        width: 45
        height: 45
        anchors.verticalCenterOffset: 0
        anchors.verticalCenter: textInput_money.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.horizontalCenterOffset: 140
        source: textInput_money.inputCorrect ? "qrc:/img/ok.png" : ""
    }

    Image {
        x: -4
        y: 233
        width: 45
        height: 45
        anchors.verticalCenter: textInput_password.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.horizontalCenterOffset: 140
        source: textInput_password.inputCorrect ? "qrc:/img/ok.png" : ""
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
