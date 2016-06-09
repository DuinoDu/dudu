import QtQuick 2.0
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.3


TextField {
    id: root

    font.pixelSize: 16
    font.family: "SimSun"
    selectByMouse: true

    property string re: ""
    property bool inputCorrect: false

    style: TextFieldStyle {
              textColor: "black"
              background: Rectangle {
                  radius: 4
                  implicitWidth: 200
                  implicitHeight: 50
                  border.color: "#A9A9A9"
                  border.width: 1
              }
              placeholderTextColor: "#A9A9A9"
          }

    onTextChanged: {
        var re = new RegExp(root.re);
        root.inputCorrect = re.test(root.text);
    }
}

