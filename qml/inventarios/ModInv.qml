import QtQuick 2.2;
import QtQuick.LocalStorage 2.0
import QtQuick.Controls 1.2
import QtQuick.Controls.Styles 1.4

import "../MyComponents/js/mensajes.js" as Mensaje

Rectangle{
	id: qml_modInv;
	height: 600;
	width: 400;
	color: Qt.rgba(0,0,0,.5);

	Component{
        id: estiloN1_textField;
        TextFieldStyle {
            placeholderTextColor: root.color_base_n3;
            background: Rectangle {
                implicitWidth: control.width;
                implicitHeight: control.height;
                radius: implicitHeight * .12;
                border.color: root.color_base_n3;
                border.width: 1
            }
        }
    }

    MouseArea{
    	anchors.fill: parent;
    	onClicked: {
    		qml_modInv.destroy();
    	}
    }
	Rectangle
	{
		id: item_cont;
		anchors.verticalCenter: parent.verticalCenter;
		anchors.horizontalCenter: parent.horizontalCenter;
		height: parent.height * .48;
		width: parent.width * .81;
		property double alto_item: qml_modInv.height * .15;
		radius: height * .045;
		Item{
            id: rg_n1;
            anchors.top: parent.top;
            anchors.topMargin: parent.height * .03;
            anchors.horizontalCenter: parent.horizontalCenter
            height: item_cont.alto_item;
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
                    text: "Nombre";
                    font.pixelSize: 21;
                    font.family: root.fuente;
                    color: root.color_base_n8;
                }
            }
            TextField {
                id: txt_nombres;
                anchors.bottom: parent.bottom;
                anchors.left: parent.left;
                width: parent.width;
                height: parent.height * .54;
                font.pixelSize: 18;
                font.family: root.fuente;
                textColor: root.color_base_n1;
                style: estiloN1_textField;
                placeholderText: "Nombre";
            }
        }
        Item{
            id: rg_n2;
            anchors.top: rg_n1.bottom;
            anchors.topMargin: parent.height * .03;
            anchors.horizontalCenter: parent.horizontalCenter
            height: item_cont.alto_item;
            width: parent.width * .9;
            Item{
            	anchors.left: parent.left;
            	width: parent.width * .5;
            	height: parent.height;
            	Item{
	                anchors.top: parent.top;
	                anchors.topMargin: parent.height * .09;
	                height: parent.height * .3;
	                width: parent.width;
	                clip: true;
	                Text{
	                    horizontalAlignment: Text.AlignLeft;
	                    verticalAlignment: Text.AlignVCenter;
	                    height: parent.height;
	                    width: parent.width;
	                    wrapMode: Text.WordWrap;
	                    text: "Fecha";
	                    font.pixelSize: 21;
	                    font.family: root.fuente;
	                    color: root.color_base_n8;
	                }
	            }
	            TextField {
	                id: txt_fecha;
	                anchors.bottom: parent.bottom;
	                anchors.left: parent.left;
	                //anchors.verticalCenter: parent.verticalCenter;
	                width: parent.width * .96;
					inputMethodHints: Qt.ImhDate;
					inputMask: "0000-00-00";
					verticalAlignment: Text.AlignVCenter;
					horizontalAlignment: Text.AlignHCenter;
					textColor: root.color_base_n1;
					placeholderText: "Fecha";
					font.pointSize: 18;
					height: parent.height * .54;
					Component.onCompleted:
					{
						var dato_fecha = new Date();
						var mes = (dato_fecha.getMonth() +1) + "";
						if(mes.length == 1)
							mes = "0"+mes+"";
						var dia = dato_fecha.getDate()+"";
						if(dia.length == 1)
							dia = "0"+dia+"";
						txt_fecha.text =  dato_fecha.getFullYear() +"-"+mes+"-"+dia;
					}
					MouseArea
					{
						anchors.fill: parent;
						onClicked:
						{
							Mensaje.selFecha(qml_modInv, function(anio, mes, dia){
								txt_fecha.text = anio+"-"+mes+"-"+dia;
							});
						}
					}
	            }
            }
            Item{
            	anchors.right: parent.right;
            	width: parent.width * .5;
            	height: parent.height;
            	Item{
	                anchors.top: parent.top;
	                anchors.topMargin: parent.height * .09;
	                height: parent.height * .3;
	                width: parent.width;
	                clip: true;
	                Text{
	                    horizontalAlignment: Text.AlignLeft;
	                    verticalAlignment: Text.AlignVCenter;
	                    height: parent.height;
	                    width: parent.width;
	                    wrapMode: Text.WordWrap;
	                    text: "Hora";
	                    font.pixelSize: 21;
	                    font.family: root.fuente;
	                    color: root.color_base_n8;
	                }
	            }
	            TextField
				{
					id: txt_hora;
					anchors.bottom: parent.bottom;
	                anchors.left: parent.left;
					height: parent.height * .54;
					width: parent.width * .96;
					inputMethodHints: Qt.ImhTime;
					verticalAlignment: Text.AlignVCenter;
					horizontalAlignment: Text.AlignHCenter;
					textColor: root.color_base_n1;
					placeholderText: "06:09";
					font.pointSize: 18;
					Component.onCompleted:
					{
						var dato_fecha = new Date();
						var ampm = "am";
						var hora = dato_fecha.getHours() + "";
						if(hora > 12)
						{
							hora = hora * 1;
							hora -= 12;
							ampm = "pm";
						}
						if(hora.length == 1)
							hora = "0"+hora+"";
						var min = dato_fecha.getMinutes()+"";
						if(min.length == 1)
							min = "0"+min+"";;
						txt_hora.text =  hora+":"+min+":"+ampm;
					}
					MouseArea
					{
						anchors.fill: parent;
						onClicked:
						{
							Mensaje.selHora(qml_modInv, function(h, m, ampm){
								txt_hora.text = h+":"+m+":"+ampm
							});
						}
					}
				}
	            
            }
        }
        Item{
            id: rg_n3;
            anchors.bottom: parent.bottom;
            anchors.horizontalCenter: parent.horizontalCenter
            height: item_cont.alto_item;
            width: parent.width * .9;
            Rectangle{
	            anchors.verticalCenter: parent.verticalCenter;
	            anchors.right: parent.right;
	            anchors.rightMargin: parent.width * .03;
	            height: parent.height * .63;
	            width: parent.width * .45;
	            radius: height * .12;
	            color: Qt.rgba(0,0,0,0);
	            border.color: root.color_base_n6;
	            border.width: 1;
	            Text{
	                anchors.fill: parent;
	                verticalAlignment: Text.AlignVCenter;
	                horizontalAlignment: Text.AlignHCenter;
	                text: "Guardar";
	                font.pixelSize: 24;
	                color: root.color_base_n8;
	                font.bold: true;
	            }
	            MouseArea{
	                anchors.fill: parent;
	                onClicked: modificar();
	            }
	        }
        }
	}
	function cargar(){
		var reg_inv = app_manager.INVENTARIOS.getJson()[app_manager.INVENTARIOS.getId()];
		txt_fecha.text = reg_inv.fecha;
		txt_nombres.text = reg_inv.nombre;
		var ampm = "am";
		var hora = reg_inv.hora.split(":")[0];
		if(hora > 12)
		{
			hora = hora * 1;
			hora -= 12;
			ampm = "pm";
		}
		if(hora.length == 1)
			hora = "0"+hora+"";
		var min = reg_inv.hora.split(":")[1];
		if(min.length == 1)
			min = "0"+min+"";;
		txt_hora.text =  hora+":"+min+":"+ampm;
	}
	function modificar(){
		var hora = txt_hora.text.split(":");
		hora = (hora[2] == "pm" ? ((hora[0] * 1) + 12) : hora[0]) +":"+hora[1]+":00";
		app_manager.INVENTARIOS.modificar(app_manager.CUENTA.id, app_manager.INVENTARIOS.getId(), txt_nombres.text, txt_fecha.text, hora, function(status, msg){
			if(status != 1){
				Mensaje.error(root, msg);
			} else {
				qml_modInv.destroy();
			}
		})
	}
}