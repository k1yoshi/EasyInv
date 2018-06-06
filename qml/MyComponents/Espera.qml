import QtQuick 2.6
import "../MyComponents/js/mensajes.js" as Message


Rectangle 
{
    id: kmsg;
    property bool espera: false;
    property int nroC: 0;

    color: Qt.rgba(55 / 255, 55 / 255, 55 / 255, 0.0);
    height: 600;
    width: 400;
    opacity: 1;

    signal showEspera(string msg, string titulo);
    signal hide;
    z: -1;
    Rectangle 
    {
    	color: Qt.rgba(0, 0, 0, 0);
	    width: animation.width; 
	    height: animation.height + 8
	    anchors.verticalCenter: parent.verticalCenter;
        anchors.horizontalCenter: parent.horizontalCenter;

	    AnimatedImage { id: animation; visible: false; source: "../../src/img/Botella-loading.gif" }
        MouseArea {
            anchors.fill: parent;
            onClicked: {
               
            }
        }
	}
    onShowEspera: {
        espera = true;
        z = 1000;
        opacity = 1;
    }
    onHide: {
        kmsg.destroy();
    }
    Timer {
        id: run_message;
        running: true
        repeat: false
        interval: 200
        onTriggered: {
            kmsg.color = Qt.rgba(55 / 255, 55 / 255, 55 / 255, 0.7);
            animation.visible = true;
        }
    }
    Timer {
        id: run_background;
        running: true
        repeat: true
        interval: 500
        onTriggered: {
            kmsg.x = 0;
            kmsg.y = 0;
            kmsg.z = 2000;
        }
    }

    MouseArea 
    {
        anchors.fill: parent;
        onClicked: 
        {
            
        }
    }
}
