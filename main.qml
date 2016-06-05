import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Dialogs 1.2
import DD 1.0

ApplicationWindow {
    visible: true
    width: 800
    height: 600

    maximumHeight : 600
    maximumWidth : 800
    minimumHeight : 600
    minimumWidth : 800

    //title: qsTr("嘟嘟鲜果")

    MainForm {
        anchors.fill: parent
    }

    Backend{
        id: db
        delta: 2.0
    }

    Component.onCompleted: console.log(db.delta)

}
