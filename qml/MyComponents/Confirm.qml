import QtQuick 2.6
import "js/mensajes.js" as Message 

Rectangle
{
    id: kconfirm;
    property alias message: msg_text.text;
    property alias time: run_message.interval;
    property alias string_opt1: btn_opt_1.text;
    property alias string_opt2: btn_opt_2.text;
    property color background_opt1: "#f00";
    property color background_opt2: "#f00";
    property color color_text: "#aaa"
    property int font_size: 24;
    property int font_size_buttom: 18;
    property string value;

    property string title: "Titulo";
    property int tipe: 0;

    color: Qt.rgba(55 / 255, 55 / 255, 55 / 255, 0.7);
    height: 600;//parent ? parent.height : 600;
    width: 400;//parent ? parent.width : 1200;
    opacity: 1;

    signal show(string msg);
    signal hide;
    signal closed(bool acepta, string value);
    z: -1;
    MouseArea
    {
        anchors.fill: parent;
        onClicked: funAceptar(false);
    }
    Rectangle
    {
        height: parent.height * 0.35;
        width: parent.width * 0.8;
        color: "#fff";
        radius: height * .09;
        anchors.verticalCenter: parent.verticalCenter;
        anchors.horizontalCenter: parent.horizontalCenter;
        Item {
            id: item_ar;
            anchors.top: parent.top;
            width: parent.width;
            height: parent.height * .6;
            Text
            {
                id: msg_text;
                font.pointSize: font_size;
                wrapMode: TextEdit.WordWrap;
                anchors.fill: parent;
                color: root.color_base_n8;
                text: "Confirma elimina";
                horizontalAlignment: Text.AlignHCenter;
                verticalAlignment: Text.AlignVCenter;
            }
        }
        Item{
            anchors.bottom: parent.bottom;
            height: parent.height -item_ar.height;
            width: parent.width;
            Rectangle{
                anchors.left: parent.left;
                anchors.leftMargin: parent.width * .05;
                anchors.verticalCenter: parent.verticalCenter;
                height: parent.height * .6;
                width: parent.width * .43;
                radius: height * .12;
                border.color: root.color_base_n6;
                border.width: 1;
                Text{
                    id: btn_opt_1;
                    anchors.fill: parent;
                    text: "Cancelar";
                    color: root.color_base_n6;
                    font.pixelSize: 18;
                    verticalAlignment: Text.AlignVCenter;
                    horizontalAlignment: Text.AlignHCenter;
                }
                MouseArea{
                    anchors.fill: parent;
                    onClicked: funAceptar(false);
                }
            }
            Rectangle{
                anchors.right: parent.right;
                anchors.rightMargin: parent.width * .05;
                anchors.verticalCenter: parent.verticalCenter;
                height: parent.height * .6;
                width: parent.width * .43;
                radius: height * .12;
                border.color: root.color_base_n6;
                border.width: 1;
                Text{
                    id: btn_opt_2;
                    anchors.fill: parent;
                    text: "Aceptar";
                    font.pixelSize: 18;
                    color: root.color_base_n6;
                    verticalAlignment: Text.AlignVCenter;
                    horizontalAlignment: Text.AlignHCenter;
                }
                MouseArea{
                    anchors.fill: parent;
                    onClicked: funAceptar(true);
                }
            }
        }
    }
    Timer
    {
        id: run_message;
        running: true
        repeat: false
        interval: 60000
        onTriggered:
        {
            hide();
        }
    }
    onShow:
    {
        message = msg;
        title = "";
        z = 1000;
        opacity = 1;
    }
    onHide:
    {
        //run_message.running = false;
        z = -1;
        //opacity = 0;
        kconfirm.destroy();
    }
    function funAceptar(status)
    {
        //if(status)
            closed(status, value);
        hide();
    }
}
