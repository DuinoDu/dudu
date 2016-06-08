import QtQuick 2.0
import QtQuick.Controls 1.3

Rectangle{
    id: root
    width: 400
    height: 400
    color: "#dddddd"

    signal recogFinger()
    signal updateMoney(string phone, string money)

    property variant searchResult: []
    onSearchResultChanged: {
        if(root.searchResult.length > 0){
            label_name.text = root.searchResult[0];
            label_phone.text = root.searchResult[1];
            label_money.text = root.searchResult[2];
        }
    }

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
        text: qsTr("100.33")
    }

    TextEdit {
        id: textEdit_cost
        x: 123
        y: 56
        width: 80
        height: 16
        text: qsTr("3.3")
        font.pixelSize: 12
    }

    Button {
        id: button_recognition
        x: 246
        y: 51
        text: qsTr("识别指纹")
        onClicked: root.recogFinger();
    }

    Button {
        id: button_ok
        x: 72
        y: 294
        text: qsTr("确认消费")
        onClicked: {
            var originMoney = parseFloat(label_money.text)
            var cost = parseFloat(textEdit_cost.text)
            var currentMoney = originMoney - cost;
            if(currentMoney < 0){
                console.log("no enough money");
                return;
            }
            label_money.text = currentMoney.toFixed(1)
            root.updateMoney(label_phone.text, label_money.text);
        }
    }

    Button {
        id: button_cancel
        x: 204
        y: 294
        text: qsTr("取消")
    }
}
