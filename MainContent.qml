import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Layouts 1.1
import QtQuick.Controls.Styles 1.4
import DD 1.0
import "ui/"


Item {
    id: root
    width: 800
    height: 480

    TabView {
        id: frame
        anchors.fill: parent
        anchors.margins: 4
        currentIndex: 1

        Tab {
            id: tab1
            title: "开户"
            CreateTab{
                width: root.width; height: root.height

                onCreateFinger: db.createFinger()

                onClosePort: db.closePort()

                onSaveClicked: {
                    var result = db.searchPhone(phone);
                    if(result.length !== 0){
                        root.showMessage(3, "");
                        return;
                    }
                    db.insertNew(name, phone, money, password, finger1, finger2)
                }

            }

            function setFingerID(fingerID){
                if (tab1.childAt(10,10).flag === 1)
                    tab1.childAt(10,10).fingerID1 = fingerID;
                else if(tab1.childAt(10,10).flag === 2)
                    tab1.childAt(10,10).fingerID2 = fingerID;
            }
        }


        Tab {
            id: tab2
            title: "消费"
            CostTab{

                onRecogFinger: {
                    console.log("put your finger on the plane");
                    db.recogFinger(0);
                }

                onClosePort: db.closePort()

                onSearchPhone: {
                    var result = db.searchPhone(phone)
                    if (result.length === 0){
                        root.showMessage(2, "");
                        tab2.childAt(10,10).clearInput();
                        return;
                    }else{
                        searchResult = result; // 0 name, 1 phone, 2 money, 3 passport
                        showInputStep(2);
                    }
                }

                onUpdateMoney: {
                    db.updateMoney(phone, money)
                }

                onFingerIDChanged: {
                    console.log("find one : "+fingerID);
                    console.log(searchResult);
                    searchResult = db.select(fingerID);
                }

            }

            function setFingerID(fingerID){
                tab2.childAt(10,10).fingerID = fingerID;
            }
        }


        Tab {
            id: tab3
            title: "充值"
            AddTab{
                onRecogFinger: {
                    console.log("put your finger on the plane");
                    db.recogFinger(1);
                }
                onUpdateMoney: {
                    db.updateMoney(phone, money)
                }
                onFingerIDChanged: {
                    console.log("find one : "+fingerID);
                    console.log(searchResult);
                    searchResult = db.select(fingerID);
                }
            }
            function setFingerID(fingerID){
                tab3.childAt(10,10).fingerID = fingerID;
            }
        }

        style: TabViewStyle {
            frameOverlap: 1
            tabsMovable: true

            tab: Rectangle {
                color: styleData.selected ? "steelblue" :"lightsteelblue"
                border.color:  "steelblue"
                implicitWidth: root.width/3
                implicitHeight: 40
                radius: 2
                Text {
                    id: text
                    anchors.centerIn: parent
                    text: styleData.title
                    color: styleData.selected ? "white" : "black"
                    font.pixelSize: 16
                    font.family: "Microsoft YaHei"
                }
            }
        }
    }

    Backend{
        id: db
        onMessage: root.showMessage(flag, msg)

        onCreateReady: {
            if (fingerID === "-1"){
                return;
            }
            else if(fingerID !== ""){
                tab1.setFingerID(fingerID);
            }
        }

        onSearchReadyCost: {

            if(fingerID === ""){
                root.showMessage(2, "");
                tab2.childAt(10,10).fingerState = 0;
                return;
            }
            else if(fingerID === "-1"){
                return;
            }

            tab2.setFingerID(fingerID);
        }

        onSearchReadyAdd: {

            if(fingerID === ""){
                root.showMessage(2, "");
                tab3.childAt(10,10).fingerState = 0;
                return;
            }
            else if(fingerID === "-1"){
                return;
            }

            tab3.setFingerID(fingerID);

        }
    }

    function showMessage(flag, msg){
        console.log(flag, msg);
        var msgStr = "";

        // decide message type
        switch (flag)
        {
        case 1:
            msgStr = "当前第" + msg + "位会员";
            break;
        case 2:
            msgStr = "当前用户不存在";
            break;

        case 3:
            msgStr = "该电话号码已注册";
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
