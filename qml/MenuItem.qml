import QtQuick 2.6
import "MyComponents/js/mensajes.js" as Mensaje

Rectangle{
	id: qml_menuItem;
	height: 600;
	width: 400;
	color: Qt.rgba(0,0,0, .5);
	visible: false;

	property string text_op_modificar: "Modificar Registro";
	property string text_op_eliminar: "Eliminar Registro";
	property string text_op_nuevo: "Agregar debajo";
	property int nIndex: -1;
	property string titulo_ventanas: "";
	property string clase: "";

	signal modificar(int status, string msg);
	signal eliminar(int status, string msg);
	signal agregarDebajo(int status, string msg);

	MouseArea{
		anchors.fill: parent;
		onClicked: qml_menuItem.destroy();
	}

	Rectangle{
		id: rect_cont;
		anchors.verticalCenter: parent.verticalCenter;
		anchors.horizontalCenter: parent.horizontalCenter;
		height: parent.height * .6;
		width: parent.width * .9;
		color: "#fff";
		radius: height * .03;

		property double alto_btn: .6;
		property string color_border: "#c9c9c9";
		property string color_texto: "#515151";
		property int pixelSize: 24;
		Item{
			id: item_n1;
			anchors.top: parent.top;
			height: parent.height / 3;
			width: parent.width;
			Rectangle{
				anchors.verticalCenter: parent.verticalCenter;
				anchors.horizontalCenter: parent.horizontalCenter;
				height: parent.height * rect_cont.alto_btn;
				width: parent.width * .9;
				color: Qt.rgba(0,0,0,0);
				border.color: rect_cont.color_border;
				border.width: 1;
				radius: height * .09;
				Text{
					anchors.fill: parent;
					text: qml_menuItem.text_op_modificar
					font.pixelSize: rect_cont.pixelSize;
					verticalAlignment: Text.AlignVCenter;
					horizontalAlignment: Text.AlignHCenter;
					color: rect_cont.color_texto;
				}
				MouseArea{anchors.fill: parent; onClicked: modificarRegistro();}
			}
		}
		Item{
			anchors.top: item_n1.bottom;
			height: parent.height / 3;
			width: parent.width;
			Rectangle{
				anchors.verticalCenter: parent.verticalCenter;
				anchors.horizontalCenter: parent.horizontalCenter;
				height: parent.height * rect_cont.alto_btn;
				width: parent.width * .9;
				color: Qt.rgba(0,0,0,0);
				border.color: rect_cont.color_border;
				border.width: 1;
				radius: height * .09;
				Text{
					anchors.fill: parent;
					text: qml_menuItem.text_op_eliminar
					font.pixelSize: rect_cont.pixelSize;
					verticalAlignment: Text.AlignVCenter;
					horizontalAlignment: Text.AlignHCenter;
					color: rect_cont.color_texto;
				}
				MouseArea{anchors.fill: parent; onClicked: eliminarRegistro();}
			}
		}
		Item{
			anchors.bottom: parent.bottom;
			height: parent.height / 3;
			width: parent.width;
			Rectangle{
				anchors.verticalCenter: parent.verticalCenter;
				anchors.horizontalCenter: parent.horizontalCenter;
				height: parent.height * rect_cont.alto_btn;
				width: parent.width * .9;
				color: Qt.rgba(0,0,0,0);
				border.color: rect_cont.color_border;
				border.width: 1;
				radius: height * .09;
				Text{
					anchors.fill: parent;
					text: qml_menuItem.text_op_nuevo
					font.pixelSize: rect_cont.pixelSize;
					verticalAlignment: Text.AlignVCenter;
					horizontalAlignment: Text.AlignHCenter;
					color: rect_cont.color_texto;
				}
				MouseArea{anchors.fill: parent; onClicked: agregarRegistroDebajo();}
			}
		}
	}

	function modificarRegistro(){
        var nombre_reg = drinkventario[clase].getModel().get(nIndex).nombre;
        Mensaje.prompt2(root, "Modificar nombre de "+titulo_ventanas+" ", nombre_reg, function(status, value){
        	if(!status){
        		qml_menuItem.modificar(0, "Se cancelo la operacion")
        	} else {
        		drinkventario[clase].modificarNombre(qml_menuItem.nIndex, value, qml_menuItem.modificar);
        	}
        });
	}
	function eliminarRegistro(){
		var nombre_reg = drinkventario[clase].getModel().get(nIndex).nombre;
		Mensaje.confirmar(root, "Confirma eliminar el "+titulo_ventanas+" " + nombre_reg, function(status, value){
			if(!status){
				qml_menuItem.eliminar(0, "Se cancelo la operacion");
			} else {
				drinkventario[clase].eliminarRegistro(qml_menuItem.nIndex, qml_menuItem.eliminar);
			}
		});
	}
	function agregarRegistroDebajo(){
		Mensaje.prompt(root, "Ingrese nombre para "+titulo_ventanas, function(status, value){
			if(!status){
				qml_menuItem.agregarDebajo(0, "Se cancelo la operacion");
			} else {
				drinkventario[clase].agregarEnPosicion(value, (nIndex+2), qml_menuItem.agregarDebajo);
			}
        });
	}

	onModificar: {
		if(status == 1){
			qml_menuItem.destroy();
		} else {
			//qml_menuItem.destroy();
			Mensaje.error(root, msg)
		}
	}
	onEliminar: {
		if(status == 1){
			qml_menuItem.destroy();
		} else {
			//qml_menuItem.destroy();
			Mensaje.error(root, msg)
		}
	}
	onAgregarDebajo: {
		if(status == 1){
			qml_menuItem.destroy();
		} else {
			//qml_menuItem.destroy();
			Mensaje.error(root, msg)
		}
	}
}