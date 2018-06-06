import QtQuick 2.6
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.1

Rectangle
{
    id: kprompt;

    property int font_size: 18;
    property string value;

    color: Qt.rgba(55 / 255, 55 / 255, 55 / 255, 0.7);
    height: 600;
    width: 400;
    opacity: 1;

    Component{
        id: estiloN1_textField;
        TextFieldStyle {
            placeholderTextColor: root.color_base_n6;
            background: Rectangle {
                implicitWidth: control.width;
                implicitHeight: control.height;
                radius: implicitHeight * .12;
                border.color: root.color_base_n10;
                border.width: 1
            }
        }
    }

    signal show(string titulo, string place);
    signal show2(string titulo, string place, string nuevo);
    signal hide;
    signal closed(bool status, string value);
    z: -1;
    
    FontLoader {id: fuente_app; source: "../../fuentes/KhmerUI.ttf";}
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
        anchors.verticalCenter: parent.verticalCenter;
        anchors.horizontalCenter: parent.horizontalCenter;
        radius: height * .06;
        Item
        {
            id: cabecera;
            anchors.top: parent.top;
            //anchors.topMargin: 10;
            height: parent.height * 0.40;  
            width: parent.width;
            Text
            {
                id: txt_titulo;
                horizontalAlignment: Text.AlignHCenter;
                verticalAlignment: Text.AlignVCenter;
                anchors.centerIn: parent;
                width: parent.width;
                height: parent.height;
                font.pointSize: 20;
                font.family: fuente_app.name;
                text: "Titulo";
                wrapMode: Text.WordWrap;
                color: root.color_base_n3;
            }
        }
        Rectangle
        {
            id: rect_text;
            //anchors.top: cabecera.bottom;
            anchors.verticalCenter: parent.verticalCenter;
            height: parent.height * 0.26;
            width: parent.width;
            TextField
            {
                id: msg_text;
                anchors.horizontalCenter: parent.horizontalCenter;
                font.pointSize: font_size;
                height: parent.height;
                width: parent.width * .9;
                textColor: root.color_base_n1;
                placeholderText: "";
                font.family: fuente_app.name;
                text: "";
                focus: true
                horizontalAlignment: Text.AlignHCenter;
                verticalAlignment: Text.AlignVCenter;
                anchors.centerIn: parent;
                style: estiloN1_textField;
            }
        }
        Item
        {
            anchors.bottom: parent.bottom;
            //anchors.bottomMargin: 2;
            height: parent.height * .33;
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
                    color: root.color_base_n3;
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
                    color: root.color_base_n3;
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
    onShow:
    {
        txt_titulo.text = titulo.toUpperCase();
        msg_text.placeholderText = place;
        msg_text.text= place;
        z = 10000;
        opacity = 1;
    }
    onShow2:
    {
        txt_titulo.text = titulo.toUpperCase();
        msg_text.placeholderText = place;
        msg_text.text= nuevo;
        z = 10000;
        opacity = 1;
    }
    onHide:
    {
        z = -1;
        opacity = 0;
        //kprompt.destroy();
    }
    function funAceptar(status)
    {
        Qt.inputMethod.hide();
        closed(status, msg_text.text);
        hide();
    }

    Component.onCompleted: {
        msg_text.focus = true;
    }
}
