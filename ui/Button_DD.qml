import QtQuick 2.4

Rectangle {
	id: root
    width: 115; height: 40
	color: "white"
	radius: 10
    border.color: root.fontColor
	
	property string text: "default"
    property string fontColor: "#80C342"
    property string frozenColor: "gray"
    property string fontFamily: "Microsoft YaHei"
	property int fontSize: 10
	property bool enableButton: true
    property bool enableLatch: true
	
    signal clicked(int state)
	
	Text{ 
		id: buttonText
		anchors.horizontalCenter: parent.horizontalCenter
		anchors.verticalCenter: parent.verticalCenter
		text: root.text
        color:root.fontColor
		font.pixelSize: root.fontSize
        font.family: root.fontFamily
	}
	MouseArea{
		id: mouseArea
		anchors.fill: parent
		hoverEnabled: true
		onEntered:{
            root.color = root.enableButton ? root.fontColor : "white"
            buttonText.color = root.enableButton ? "white" : root.fontColor
		}
		onExited:{
            root.color = "white"
            buttonText.color = root.fontColor
		}
        onClicked:{
            if(root.enableButton){
                if(root.enableLatch){
                    if(root.btnState === 0)
                        root.btnState = 1;
                    else
                        root.btnState = 0;
                }
                root.clicked(root.btnState);
            }
        }
	}
    property int btnState: 0
}
