import QtQuick 2.0
import QtQuick.Controls 1.3
import "ui/"

Rectangle{
    id: root
    width: 800
    height: 500
    color: "#dddddd"

    signal recogFinger()
    signal closePort()
    property int fingerState: 0 // 0 is to open port, 1 is to close port


    signal searchPhone(string phone)
    signal updateMoney(string phone, string money)

    property string fingerID: ""
    onFingerIDChanged: {  console.log("fingerState: ",root.fingerState);  root.fingerState = 0;}

    property variant searchResult: []
    onSearchResultChanged: {
        if(root.searchResult.length > 0){
            label_name.text = root.searchResult[0];
            label_phone.text = root.searchResult[1];
            label_money.text = root.searchResult[2];
        }
    }

    property int inputTypeFlag: 0 // 0 is finger input, 1 is passport input
    onInputTypeFlagChanged: {
        root.showInputStep(1);
        root.clearInput();
    }

    Image{
        anchors.fill: parent
        fillMode: Image.PreserveAspectCrop
        source: "qrc:/img/bg5.jpg"
    }

    Rectangle{
        x: 221
        y: 27
        width: 500
        height: 440
        color: "black"
        radius: 10
        anchors.verticalCenterOffset: 0
        anchors.horizontalCenterOffset: 0
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        opacity: 0.4
    }

    Image{
        x: 287
        y: 198
        width: 45
        height: 45
        anchors.verticalCenterOffset: -30
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenterOffset: -140
        anchors.horizontalCenter: parent.horizontalCenter
        source: "qrc:/img/username.png"
    }

    Image{
        x: 77
        y: 258
        width: 24
        height: 45
        anchors.verticalCenterOffset: 30
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenterOffset: -140
        anchors.horizontalCenter: parent.horizontalCenter
        source: "qrc:/img/phone.png"
    }

    Image{
        x: 66
        y: 318
        width: 45
        height: 45
        anchors.verticalCenterOffset: 90
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenterOffset: -140
        anchors.horizontalCenter: parent.horizontalCenter
        source: "qrc:/img/money.png"
    }

    Image{
        x: 66
        y: 53
        width: 45
        height: 45
        anchors.verticalCenterOffset: -150
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenterOffset: -140
        anchors.horizontalCenter: parent.horizontalCenter
        source: "qrc:/img/rmb.png"
    }

    Image{
        id: inputType
        x: 287
        y: 123
        width: 45
        height: 45
        anchors.verticalCenterOffset: -90
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenterOffset: -140
        anchors.horizontalCenter: parent.horizontalCenter
        source: "qrc:/img/changeInput.png"

        MouseArea{
            anchors.fill: parent
            hoverEnabled: true
            onEntered: {
                inputType.width *= 1.5;
                inputType.height *= 1.5;
            }
            onExited: {
                inputType.width /= 1.5;
                inputType.height /= 1.5;
            }
            onClicked: root.inputTypeFlag = ( root.inputTypeFlag === 0 ) ? 1 : 0
        }

    }


    Image{
        y: 53
        width: 45
        height: 45
        anchors.verticalCenterOffset: -150
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenterOffset: 140
        anchors.horizontalCenter: parent.horizontalCenter
        source: textEdit_cost.inputCorrect ? "qrc:/img/ok.png" : ""
    }

    Input_DD {
        id: label_name
        x: 154
        y: 195
        anchors.verticalCenterOffset: -30
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenterOffset: 0
        anchors.horizontalCenter: parent.horizontalCenter
        placeholderText: qsTr("姓名")
        enabled: false
    }

    Input_DD {
        id: label_phone
        x: 154
        y: 255
        anchors.verticalCenterOffset: 30
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenterOffset: 0
        anchors.horizontalCenter: parent.horizontalCenter
        placeholderText: qsTr("电话号码")
        enabled: (root.inputTypeFlag === 1)
        re: "^1\\d{10}$"
        //onInputCorrectChanged: //root.showInputStep(2)
    }

    Image{
        id: searchButton
        y: 258
        width: 45
        height: 45
        anchors.verticalCenterOffset: 30
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenterOffset: 140
        anchors.horizontalCenter: parent.horizontalCenter
        source: (label_phone.inputCorrect && root.inputTypeFlag === 1) ? "qrc:/img/search.png" : ""

        MouseArea{
            anchors.fill: parent
            hoverEnabled: label_phone.inputCorrect
            onEntered: {
                searchButton.width *= 1.5;
                searchButton.height *= 1.5;
            }
            onExited: {
                searchButton.width /= 1.5;
                searchButton.height /= 1.5;
            }
            onClicked: root.searchPhone(label_phone.text)
        }

    }

    Input_DD {
        id: label_money
        x: 154
        y: 315
        anchors.verticalCenterOffset: 90
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenterOffset: 0
        anchors.horizontalCenter: parent.horizontalCenter
        placeholderText: qsTr("余额")
        enabled: false
    }

    Input_DD {
        id: textEdit_cost
        x: 123
        y: 50
        anchors.verticalCenterOffset: -150
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenterOffset: 0
        anchors.horizontalCenter: parent.horizontalCenter
        placeholderText: "充值金额"
        re: "[^\d.]"
    }

    Image{
        id: button_recognition
        x: 384
        y: 124
        width: 45
        height: 45
        anchors.verticalCenterOffset: -90
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenterOffset: 0
        anchors.horizontalCenter: parent.horizontalCenter
        visible: (root.inputTypeFlag === 0)
        source:  root.fingerID === "" ? "qrc:/img/finger_off.png" : "qrc:/img/finger_on.png"

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
            onClicked: {
                if (root.fingerState === 0){
                    root.recogFinger();
                    root.fingerState = 1;
                }else if (root.fingerState === 1){
                    root.closePort();
                    root.fingerState = 0;
                }
            }
        }
    }

    Input_DD {
        id: textEdit_password
        x: 123
        y: 121
        anchors.verticalCenterOffset: -90
        anchors.verticalCenter: parent.verticalCenter
        visible: (root.inputTypeFlag === 1)
        enabled: label_phone.inputCorrect
        anchors.horizontalCenterOffset: 0
        anchors.horizontalCenter: parent.horizontalCenter
        placeholderText: "密码"
        echoMode: TextInput.Password
        re: "^\\d{6}$"
        onInputCorrectChanged: {
            if(inputCorrect){
                if(text === root.searchResult[3]){
                    passwordOKIcon.source = "qrc:/img/ok.png"
                }else{
                    showMessage(4, "");
                }
            }else{
                passwordOKIcon.source = ""
            }

        }
    }

    Image{
        id: passwordOKIcon
        y: 123
        width: 45
        height: 45
        anchors.verticalCenterOffset: -90
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenterOffset: 140
        anchors.horizontalCenter: parent.horizontalCenter
    }

    Button_DD {
        id: button_ok
        x: 249
        y: 408
        text: qsTr("确认充值")
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
        enabled: (textEdit_cost.inputCorrect && (root.fingerID!=="" || textEdit_password.inputCorrect)) ? true : false
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
        anchors.horizontalCenterOffset: 80
        anchors.verticalCenterOffset: 165
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        width: 115; height: 40
        radius: 20
        border.color: "#80C342"
        fontColor: "#80C342"
        fontSize: 18
        fontFamily: "SimSun"
        onClicked: root.clearInput()

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

        case 4:
            msgStr = "密码不正确，请重新输入！";
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

    function showInputStep(step){

        // step means assistant step for keyboard input
        // 1 to input phone, 2 to input passport

        var component, msgBox;

        if(root.inputTypeFlag === 1){
            if(step === 1){
                component = Qt.createComponent("ui/Assistant_DD.qml");
                msgBox = component.createObject(root, {
                    "width":150 ,
                    "anchors.left": label_phone.right,
                    "anchors.top": label_phone.top,
                    "anchors.topMargin": -10,
                    "text": "输入手机号"});
                if (msgBox === null) {
                    console.log("Error creating object");
                }
                msgBox.destroy(1800);

            }else if(step === 2){
                component = Qt.createComponent("ui/Assistant_DD.qml");
                msgBox = component.createObject(root, {
                    "width":150 ,
                    "anchors.left": textEdit_password.right,
                    "anchors.leftMargin": 10,
                    "anchors.top": button_recognition.top,
                    "anchors.topMargin": -10,
                    "text": "输入密码"});
                if (msgBox === null) {
                    console.log("Error creating object");
                }
                msgBox.destroy(1800);
            }

        }else if(root.inputTypeFlag === 0 ){
            component = Qt.createComponent("ui/Assistant_DD.qml");
            msgBox = component.createObject(root, {
                "width":150 ,
                "anchors.left": button_recognition.right,
                "anchors.leftMargin": 72,
                "anchors.top": button_recognition.top,
                "anchors.topMargin": -10,
                "text": "识别指纹"});
            if (msgBox === null) {
                console.log("Error creating object");
            }
            msgBox.destroy(1800);
        }
    }

    function clearInput(){
        fingerID = ""
        searchResult = []
        textEdit_cost.text = ""
        label_name.text = ""
        label_phone.text = ""
        label_money.text = ""
        textEdit_password.text = ""
    }
}
