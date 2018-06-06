import QtQuick 2.6

Rectangle
{
    id: qml_mensajeError;
    property alias message: msg_text.text;
    property alias time: run_message.interval;
    property bool espera: false;

    property string title: "Titulo";
    property int tipe: 0;

    color: Qt.rgba(55 / 255, 55 / 255, 55 / 255, 0.7);
    height: parent ? parent.height : 600;
    width: parent ? parent.width : 1200;
    opacity: 1;

    signal show(string msg, string titulo);
    signal showEspera(string msg, string titulo);
    signal hide;
    z: -1;

    Image {
    	id: img_cont;
        height: parent.height * 0.35;
        width: parent.width * 0.8;
        source: "img/backmenu.png";
        anchors.verticalCenter: parent.verticalCenter;
        anchors.horizontalCenter: parent.horizontalCenter;
        Text {
            id: msg_text;
            font.pointSize: 20;
            color: "#fff";
            wrapMode: TextEdit.WordWrap;
            anchors.fill: parent;
            text: "";
            verticalAlignment: Text.AlignVCenter;
            horizontalAlignment: Text.AlignHCenter;
        }
        Rectangle{
            height: parent.height * .15;
            width: parent.width * .15;
            border.width: 1;
            border.color: "#c9c9c9";
            color: Qt.rgba(0, 0, 0, 0);
            anchors.bottom: parent.bottom;
            anchors.right: parent.right;
            anchors.bottomMargin: 16;
            anchors.rightMargin: 16;
            Text{
                anchors.fill: parent;
                text: "OK";
                color: "white";
                font.pointSize: 16;
                verticalAlignment: Text.AlignVCenter;
                horizontalAlignment: Text.AlignHCenter;
                
            }
        }
    }
    Rectangle{
    	anchors.left: img_cont.left;
    	anchors.top: img_cont.top;
    	height: 2;
    	width: img_cont.width;
    	color: "red";
    }
    MouseArea {
        anchors.fill: parent;
        onClicked: {
            if(! espera)
                hide();
        }
    }
    Timer {
        id: run_message;
        running: false
        repeat: false
        interval: 0
        onTriggered: {
            hide();
        }
    }
    onShow: {
        //espera = false;
        message = msg;
        if(time > 0)
            run_message.running = true;
        else
            run_message.running = false;
        if(titulo != undefined)
            title = titulo;
        z = 9000;
        opacity = 1;

    }
    onShowEspera: {
        espera = true;
        message = msg;
        run_message.running = false;
        if(titulo != undefined)
            title = titulo;
        z = 1000;
        opacity = 1;
    }
    onHide: {
        qml_mensajeError.destroy();
    }
}
