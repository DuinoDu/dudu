import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Layouts 1.1
import QtQuick.Controls.Styles 1.4
import DD 1.0
import "ui/"


Item {
    id: root
    width: 640
    height: 480

    TabView {
        id: frame
        anchors.fill: parent
        anchors.margins: 4
        currentIndex: 1
        Tab {
            title: "开户"
            CreateTab{
                anchors.fill: parent
                onSaveClicked: db.insertNew(name, phone, money, password, finger1, finger2)
            }

        }
        Tab {
            title: "消费"
            CostTab{
                anchors.fill: parent
            }
        }
        Tab {
            title: "充值"
            AddTab{
                anchors.fill: parent
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
