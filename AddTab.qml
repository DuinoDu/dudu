import QtQuick 2.0
import QtQuick.Controls 1.3
import "ui/"

Rectangle{
    id: root
    width: 800
    height: 500
    color: "#dddddd"

    signal recogFinger()
    signal updateMoney(string phone, string money)

    property string fingerID: ""

    property variant searchResult: []
    onSearchResultChanged: {
        if(root.searchResult.length > 0){
            label_name.text = root.searchResult[0];
            label_phone.text = root.searchResult[1];
            label_money.text = root.searchResult[2];
        }
    }

    Image{
        anchors.fill: parent
        fillMode: Image.PreserveAspectCrop
        source: "./img/bg5.jpg"
    }

    Image{
        x: 287
        y: 198
        width: 45
        height: 45
        anchors.horizontalCenterOffset: -108
        anchors.horizontalCenter: parent.horizontalCenter
        source: "./img/username.png"
    }

    Image{
        x: 77
        y: 258
        width: 24
        height: 45
        anchors.horizontalCenterOffset: -108
        anchors.horizontalCenter: parent.horizontalCenter
        source: "./img/phone.png"
    }

    Image{
        x: 66
        y: 318
        width: 45
        height: 45
        anchors.horizontalCenterOffset: -108
        anchors.horizontalCenter: parent.horizontalCenter
        source: "./img/money.png"
    }

    Image{
        x: 66
        y: 53
        width: 45
        height: 45
        anchors.horizontalCenterOffset: -108
        anchors.horizontalCenter: parent.horizontalCenter
        source: "./img/rmb.png"
    }


    Image{
        y: 53
        width: 45
        height: 45
        anchors.horizontalCenterOffset: 166
        anchors.horizontalCenter: parent.horizontalCenter
        source: textEdit_cost.inputCorrect ? "./img/ok.png" : ""
    }

    Input_DD {
        id: label_name
        x: 154
        y: 195
        anchors.horizontalCenterOffset: 27
        anchors.horizontalCenter: parent.horizontalCenter
        placeholderText: qsTr("姓名")
        enabled: false
    }

    Input_DD {
        id: label_phone
        x: 154
        y: 255
        anchors.horizontalCenterOffset: 27
        anchors.horizontalCenter: parent.horizontalCenter
        placeholderText: qsTr("电话号码")
        enabled: false
    }

    Input_DD {
        id: label_money
        x: 154
        y: 315
        anchors.horizontalCenterOffset: 27
        anchors.horizontalCenter: parent.horizontalCenter
        placeholderText: qsTr("余额")
        enabled: false
    }

    Input_DD {
        id: textEdit_cost
        x: 123
        y: 50
        anchors.horizontalCenterOffset: 27
        anchors.horizontalCenter: parent.horizontalCenter
        placeholderText: "充值金额"
        re: "[^\d.]"
    }

    Image{
        id: button_recognition
        x: 384
        y: 123
        width: 45
        height: 45
        anchors.horizontalCenter: parent.horizontalCenter
        source:  root.fingerID === "" ? "./img/finger_off.png" : "./img/finger_on.png"

        MouseArea{
            anchors.rightMargin: 0
            anchors.bottomMargin: -2
            anchors.leftMargin: 0
            anchors.topMargin: 2
            anchors.fill: parent
            enabled: (root.fingerID==="") ? true : false
            hoverEnabled: true
            onEntered: {
                button_recognition.width *= 1.2;
                button_recognition.height *= 1.2;
            }
            onExited: {
                button_recognition.width /= 1.2;
                button_recognition.height /= 1.2;
            }
            onClicked: root.recogFinger()
        }
    }

    Button_DD {
        id: button_ok
        x: 249
        y: 408
        text: qsTr("确认充值")
        anchors.horizontalCenterOffset: -80
        anchors.horizontalCenter: parent.horizontalCenter
        width: 115; height: 40
        radius: 20
        border.color: "#80C342"
        fontColor: "#80C342"
        fontSize: 18
        fontFamily: "SimSun"
        enabled: (textEdit_cost.inputCorrect && root.fingerID!=="") ? true : false
        onClicked: {
            var originMoney = parseFloat(label_money.text)
            var add = parseFloat(textEdit_cost.text)
            var currentMoney = originMoney + add;

            label_money.text = currentMoney.toFixed(1)
            root.updateMoney(label_phone.text, label_money.text);
            root.showMessage(1, "");
        }
    }

    Button_DD {
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
        onClicked:{
            fingerID = ""
            searchResult = []
            textEdit_cost.text = ""
            label_name.text = ""
            label_phone.text = ""
            label_money.text = ""
        }

    }

    function showMessage(flag, msg){
        console.log(flag, msg);
        var msgStr = "";

        // decide message type
        switch (flag)
        {
        case 1:
            msgStr = "充值成功！";
            break;

        default:
            break;
        }

        // dynamic create component
        var component = Qt.createComponent("ui/MessageBox_DD.qml");
        var msgBox = component.createObject(root, {"x": root.width/2 - 150, "y":root.height/2 - 50, "text": msgStr});

        if (msgBox === null) {
            console.log("Error creating object");
        }
        msgBox.destroy(1800);
    }
}
