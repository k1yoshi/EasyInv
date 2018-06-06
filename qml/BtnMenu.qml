import QtQuick 2.2

Item{
	id: qml_btn;
	height: 90;
	width: 90;
	property string color_border: root.color_base_n6;
	property string color_texto: root.color_base_n9;
	Rectangle{
    	id: btn_subMenu;
        anchors.verticalCenter: parent.verticalCenter;
        anchors.horizontalCenter: parent.horizontalCenter;
        color: Qt.rgba(0,0,0,0);
        height: parent.height;
        width: height;
        radius: height / 2;
        border.width: 1;
        border.color: qml_btn.color_border;

        Column{
            anchors.verticalCenter: parent.verticalCenter;
            anchors.horizontalCenter: parent.horizontalCenter;
            width: parent.width * .1;
            spacing: 6;
            Rectangle{
                width: parent.width;
                height: width;
                radius: height * .5;
                color: qml_btn.color_texto;
            }
            Rectangle{
                width: parent.width;
                height: width;
                radius: height * .5;
                color: qml_btn.color_texto;
            }
            Rectangle{
                width: parent.width;
                height: width;
                radius: height * .5;
                color: qml_btn.color_texto;
            }
        }

    }
}