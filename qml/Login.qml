import QtQuick 2.1
import QtQuick.LocalStorage 2.0
import QtQuick.Controls 1.2
import QtQuick.Controls.Styles 1.4

//import descargas.imagen 1.0

import "MyComponents"
import "MyComponents/js/mensajes.js" as Mensaje
import "../js/db.js" as Db
import "../js/util.js" as Util

Rectangle {
	id: qml_login;
    height: 600;
    width: 400;
    color: "#fff";

    property double altoTextField: height * .07;
    
    signal login;
    signal nuevaCuenta;

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
    Component{
        id: estilo_check;
        CheckBoxStyle {
            indicator: Rectangle {
                implicitHeight: control.height * .72;
                implicitWidth: implicitHeight;
                radius: 3
                border.color: control.activeFocus ? "darkblue" : "gray"
                border.width: 1
                Rectangle {
                    visible: control.checked
                    color: "#555"
                    border.color: "#333"
                    radius: 1
                    anchors.margins: 4
                    anchors.fill: parent
                }
            }
        }
    }

    /*Image {
		id: img_base;
		width: parent.width;
		height: parent.height;
		source: "../src/img/backlogin.png";
	}*/
	Image {
        id: img_logo;
        anchors.top: parent.top;
        anchors.topMargin: parent.height * 0.05;
        anchors.bottomMargin: parent.height * 0.3;
        width: parent.width * 0.8;
        height: parent.height * 0.45;
        source: "../src/img/logo.png";
        anchors.horizontalCenter: parent.horizontalCenter;
    }
    Rectangle {
        id: cuadro;
        color: Util.Color.rgba(0, 0, 0, 0);
        //anchors.bottom: row_abajo.top;
        anchors.top: parent.top;
        anchors.topMargin: parent.height * 0.42;
        anchors.horizontalCenter: parent.horizontalCenter;
        anchors.bottomMargin: parent.height * 0.03;
        width: parent.width * 0.8;
        height: parent.height * 0.5;
        TextField {
            id: txt_username;
            anchors.top: parent.top;
            anchors.topMargin: cuadro.height * 0.07;
            font.pointSize: 20;
            width: parent.width * 0.9;
            readOnly: false;
            text: "juanjo@cixneo.com";
            placeholderText: "Usuario";
            textColor: root.color_base_n8;
            font.family: root.fuente;
            anchors.horizontalCenter: parent.horizontalCenter;
            style: TextFieldStyle {
                placeholderTextColor: root.color_base_n10;
                background: Rectangle {
                    implicitHeight: cuadro.height * 0.2;
                    color: Qt.rgba(0, 0, 0, 0);
                    opacity: 0.6;
                }
            }
        }
        Rectangle {
            anchors.top: txt_username.bottom;
            color: root.color_base_n6;
            width: parent.width * 0.9;
            height: 1;
            anchors.horizontalCenter: parent.horizontalCenter;
        }
        TextField {
            id: txt_pw;
            anchors.top: txt_username.bottom;
            anchors.topMargin: cuadro.height * 0.07;
            font.pointSize: 20;
            width: parent.width * 0.9;
            readOnly: false;
            placeholderText: "Password";
            text: "123";
            textColor: root.color_base_n8;
            font.family: root.fuente;
            anchors.horizontalCenter: parent.horizontalCenter;
            echoMode: TextInput.Password;
            style: TextFieldStyle {
                placeholderTextColor: root.color_base_n10;
                background: Rectangle {
                    implicitHeight: cuadro.height * 0.2;
                    color: Util.Color.rgba(0, 0, 0, 0);
                    opacity: 0.6;
                }
            }
        }
        Rectangle {
            anchors.top: txt_pw.bottom;
            color: root.color_base_n6;
            width: parent.width * 0.9;
            height: 1;
            anchors.horizontalCenter: parent.horizontalCenter;
        }
        Item{
            anchors.top: txt_pw.bottom;
            anchors.topMargin: cuadro.height * 0.045;
            width: parent.width;
            height: parent.height * .1;
            CheckBox {
                id: chk_recordar;
                anchors.bottom: parent.bottom;
                //anchors.verticalCenter: parent.verticalCenter;
                anchors.left: parent.left;
                anchors.leftMargin: cuadro.width * 0.05;
                width: cuadro.width * 0.10;
                height: parent.height * .9;
                checked: true;
                style: estilo_check;
                //anchors.horizontalCenter: parent.horizontalCenter;
            }
            Text {
                anchors.verticalCenter: parent.verticalCenter;
                anchors.left: chk_recordar.right;
                //anchors.leftMargin: cuadro.width * 0.18;
                text: Db.RECUERDAME;
                font.pointSize: 14;
                color: root.color_base_n8;
                font.family: root.fuente;
                height: parent.height;
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter;
            }
            MouseArea{
                anchors.fill: parent;
                onClicked: {
                    chk_recordar.checked = !chk_recordar.checked;
                }
            }
        }
        
        Item {
            anchors.bottom: parent.bottom;
            //anchors.topMargin: cuadro.height * 0.15;
            //anchors.bottomMargin: cuadro.height * 0.03;
            width: parent.width * 0.9;
            height: cuadro.height * 0.2;
            anchors.horizontalCenter: parent.horizontalCenter;
            Rectangle {
                id: btn_ing;
                height: parent.height;
                width: parent.width;
                color: Qt.rgba(0,0,0,0);//"#D8D8D8";
                radius: height * .12;
                border.color: root.color_base_n6;
                border.width: 1;
                Text {
                    text: Db.INGRESAR;
                    color: root.color_base_n6;
                    font.pointSize: 27;
                    font.family: root.fuente;
                    anchors.horizontalCenter: parent.horizontalCenter;
                    anchors.verticalCenter: parent.verticalCenter;
                }
                MouseArea {
                    anchors.fill: parent;
                    onClicked: qml_login.login();
                }
            }
        }
    }
    Item {
        id: row_abajo;
        anchors.bottom: parent.bottom;
        anchors.horizontalCenter: parent.horizontalCenter;
        //anchors.bottomMargin: parent.height * 0.009;
        width: parent.width * 0.8;
        height: parent.height * 0.06;

        Text {
            id: txt2;
            //anchors.left: txt1.right;
            text: Db.TXT_INI_2;
            color: root.color_base_n1;
            font.pointSize: 14;
            font.family: root.fuente;
            font.bold: true;
            anchors.verticalCenter: parent.verticalCenter;
            MouseArea {
                anchors.fill: parent;
                onClicked: {
                    nuevaCuenta();
                }
            }
        }
    }

    Rectangle{
        id: rect_nuevo;
        anchors.fill: parent;
        color: Qt.rgba(0,0,0,.5);
        visible: false;
        MouseArea{
            anchors.fill: parent;
            onClicked: rect_nuevo.visible = false;
        }
        Rectangle{
            anchors.verticalCenter: parent.verticalCenter;
            anchors.horizontalCenter: parent.horizontalCenter;
            height: parent.height * .72;
            width: parent.width * .9;
            radius: height * .015;
            Item{
                anchors.top: parent.top;
                height: parent.height * .8;
                width: parent.width;
                Item{
                    id: rg_n1;
                    anchors.top: parent.top;
                    anchors.topMargin: parent.height * .1;
                    anchors.horizontalCenter: parent.horizontalCenter
                    height: qml_login.height * .12;
                    width: parent.width * .9;
                    Item{
                        anchors.top: parent.top;
                        height: parent.height * .3;
                        width: parent.width;
                        clip: true;
                        Text{
                            horizontalAlignment: Text.AlignLeft;
                            verticalAlignment: Text.AlignVCenter;
                            height: parent.height;
                            width: parent.width;
                            wrapMode: Text.WordWrap;
                            text: "E-mail";
                            font.pixelSize: 24;
                            font.family: root.fuente;
                            color: root.color_base_n8;
                        }
                    }
                    TextField {
                        id: txt_email_nuevo;
                        anchors.bottom: parent.bottom;
                        anchors.left: parent.left;
                        width: parent.width;
                        height: qml_login.altoTextField //parent.height * .68;
                        font.pixelSize: 24;
                        font.family: root.fuente;
                        textColor: root.color_base_n3;
                        style: estiloN1_textField;
                        placeholderText: "email@dominio.com";
                    }
                }
                Item{
                    id: rg_n2;
                    anchors.top: rg_n1.bottom;
                    anchors.topMargin: parent.height * .1;
                    anchors.horizontalCenter: parent.horizontalCenter
                    height: qml_login.height * .12;
                    width: parent.width * .9;
                    Item{
                        anchors.top: parent.top;
                        height: parent.height * .3;
                        width: parent.width;
                        clip: true;
                        Text{
                            horizontalAlignment: Text.AlignLeft;
                            verticalAlignment: Text.AlignVCenter;
                            height: parent.height;
                            width: parent.width;
                            wrapMode: Text.WordWrap;
                            text: "Password";
                            font.pixelSize: 24;
                            font.family: root.fuente;
                            color: root.color_base_n8;
                        }
                    }
                    TextField {
                        id: txt_pw_nuevo;
                        anchors.bottom: parent.bottom;
                        anchors.left: parent.left;
                        width: parent.width;
                        height: qml_login.altoTextField //parent.height * .68;
                        font.pixelSize: 24;
                        font.family: root.fuente;
                        textColor: root.color_base_n3;
                        style: estiloN1_textField;
                        placeholderText: "******";
                        echoMode: TextInput.Password;
                    }
                }
                Item{
                    id: rg_n3;
                    anchors.top: rg_n2.bottom;
                    anchors.topMargin: parent.height * .1;
                    anchors.horizontalCenter: parent.horizontalCenter
                    height: qml_login.height * .12;
                    width: parent.width * .9;
                    Item{
                        anchors.top: parent.top;
                        height: parent.height * .3;
                        width: parent.width;
                        clip: true;
                        Text{
                            horizontalAlignment: Text.AlignLeft;
                            verticalAlignment: Text.AlignVCenter;
                            height: parent.height;
                            width: parent.width;
                            wrapMode: Text.WordWrap;
                            text: "Usuario";
                            font.pixelSize: 24;
                            font.family: root.fuente;
                            color: root.color_base_n8;
                        }
                    }
                    TextField {
                        id: txt_username_nuevo;
                        anchors.bottom: parent.bottom;
                        anchors.left: parent.left;
                        width: parent.width;
                        height: qml_login.altoTextField //parent.height * .68;
                        font.pixelSize: 24;
                        font.family: root.fuente;
                        textColor: root.color_base_n3;
                        style: estiloN1_textField;
                        placeholderText: "Usuario";
                    }
                }
            }
            Item{
                id: item_nuevo;
                //anchors.horizontalCenter: parent.horizontalCenter;
                anchors.bottom: parent.bottom;
                height: parent.height * .2;
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
                        anchors.fill: parent;
                        text: "Cancelar";
                        color: root.color_base_n6;
                        font.pixelSize: 18;
                        verticalAlignment: Text.AlignVCenter;
                        horizontalAlignment: Text.AlignHCenter;
                    }
                    MouseArea{
                        anchors.fill: parent;
                        onClicked: rect_nuevo.visible = false;
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
                        anchors.fill: parent;
                        text: "Registrarme";
                        font.pixelSize: 18;
                        color: root.color_base_n6;
                        verticalAlignment: Text.AlignVCenter;
                        horizontalAlignment: Text.AlignHCenter;
                    }
                    MouseArea{
                        anchors.fill: parent;
                        onClicked: qml_login.registrar();
                    }
                }
            }
        }
    }
    onLogin:{
        Mensaje.esperar(root, "");
        app_manager.CUENTA.iniciar(chk_recordar.checked, txt_username.text, txt_pw.text, function(status, msg){
            Mensaje.hide();
            if(status == 1)
                contenedor_qml.setSource("Maestro.qml", {index: 0});
            else
                app_manager.LOG.mostrar(msg);
        });
    }
    onNuevaCuenta: {
        rect_nuevo.visible = true;
    }

    Component.onCompleted: {
        app_manager.CUENTA.preparar(chk_recordar, txt_username, txt_pw);
    }

    function registrar(){
        Mensaje.esperar(root, "");
        app_manager.CUENTA.crear(txt_email_nuevo.text, txt_pw_nuevo.text, txt_username_nuevo.text, function(status, msg){
            Mensaje.hide();
            if(status == 1)
                contenedor_qml.setSource("Maestro.qml", {index: 0});
            else
                app_manager.LOG.mostrar(msg);
        });
    }
}