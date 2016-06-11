import QtQuick 2.0
import QtQuick.Controls 1.3
import "ui/"

Rectangle{
    id: root
    width: 800
    height: 500
    color: "#dddddd"

    Image{
        anchors.fill: parent
        fillMode: Image.PreserveAspectCrop
        source: "qrc:/img/bg7.jpg"
    }
}
