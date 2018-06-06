import QtQuick 2.2
import QtQuick.LocalStorage 2.0
import QtQuick.Controls 1.2
import QtQuick.Controls.Styles 1.4

import "../MyComponents"
import "../"
import "../MyComponents/js/mensajes.js" as Mensaje
import "../../js/db.js" as Db
import "../../js/util.js" as Util
import "../delegates"
import "../headers"
import "../footers"

Rectangle 
{
	id: qml_nuevoItem;
	height: 600;
    width: 400;

    property bool animar: false;
    property double tiempo_animacion: 300.00;
    property int tipo_item: 1;

    property int orden: 0;
    property int id_grupo: 0;
    property int id_item: 0;
    property string nombre_grupo: "";
    property int id_reg: 0;
    property string nombre_reg: "";
    property string id_referencia: "";
    property double cant_incial: 0.00;
    
    visible: false;
    x: -width;

    signal iniciar;
    signal fin;
    signal mostrarMenuVistas;
    signal desaparecer;

    Behavior on x {NumberAnimation {duration: animar ? tiempo_animacion : 0;}}

    ListModel{
    	id: model_items;
    	/*ListElement{
    		Id: 5; nombre: "Grupo 1"; id_ref: 9;
    	}*/
    }
    
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
    Component{
		id: estilo_combo;
		ComboBoxStyle {
            label: Rectangle
            {
                height: control.height;
                width: parent.width
                color: root.color_base_n7;
                radius: height * .09;
                Text 
                {
                    anchors.fill: parent;
                    font.family: root.fuente;
                    font.pixelSize: 18;
                    text: control.editText;
                    verticalAlignment: Text.AlignVCenter;
                    horizontalAlignment: Text.AlignHCenter;
                    color: "#fff";
                }
            }
            background: Rectangle
            {
                height: control.height;
                width: parent.width
                color: root.color_base_n7;
                radius: height * .09;
                Text 
                {
                    anchors.fill: parent;
                    font.family: root.fuente;
                    font.pixelSize: 18;
                    text: control.editText;
                    verticalAlignment: Text.AlignVCenter;
                    horizontalAlignment: Text.AlignHCenter;
                    color: "#fff";
                }
            } 
        }
	}

    HeaderSimple {
        id: header;
        anchors.left: parent.left;
        width: parent.width;
        height: parent.height * 0.07;
        onBack: desaparecer();
        titulo: "";
    }

  	Item{
  		id: body;
  		anchors.top: header.bottom;
  		height: parent.height - header.height - footer.height;
  		width: parent.width;
  		Item{
  			id: row_n1;
  			anchors.top: parent.top;
  			height: parent.height * .12;
  			width: parent.width;
  			ComboBox {
				id: combo_grupos;
				anchors.verticalCenter: parent.verticalCenter;
				anchors.left: parent.left;
				anchors.leftMargin: parent.width * .03;
			    width: parent.width * .63;
			    height: parent.height * .72;
			    model: model_grupos;
			    style: estilo_combo;
			}
  			Image {
  				id: img_lupa;
  				anchors.verticalCenter: parent.verticalCenter;
  				anchors.right: btn_add_grupo.left;
  				anchors.rightMargin: parent.width * .03;
  				height: parent.height * .72;
  				width: height;
                visible: false;
  				source: "../../src/img/lupa.png";
  				MouseArea{
  					anchors.fill: parent;
  					onClicked: buscarGrupo();
  				}
  			}
  			Rectangle{
  				id: btn_add_grupo;
				anchors.verticalCenter: parent.verticalCenter;
				anchors.left: combo_grupos.right;
				anchors.leftMargin: parent.width * .03;
				height: parent.height * .72;
				width: height;
				radius: height * .5;
				color: Qt.rgba(0,0,0,0);
				border.color: root.color_base_n1;
				border.width: 1;
				Text{
					anchors.fill: parent;
					verticalAlignment: Text.AlignVCenter;
					horizontalAlignment: Text.AlignHCenter;
					text: "+";
					font.pixelSize: 24;
					color: root.color_base_n3;
					font.bold: true;
				}
				MouseArea{
					anchors.fill: parent;
					onClicked: nuevoGrupo();
				}
			}
  		}
  		Item{
  			id: row_n2;
  			anchors.top: row_n1.bottom;
  			height: parent.height * .1;
  			width: parent.width;

  			Item{
  				id: item_c1;
  				anchors.left: parent.left;
  				height: parent.height;
  				width: parent.width * .5;
  				Image{
  					id: img_c1;
  					anchors.verticalCenter: parent.verticalCenter;
  					anchors.left: parent.left;
  					anchors.leftMargin: parent.width * .03;
  					height: parent.height * .72;
  					width: height;
  					source: tipo_item == 1 ? "../../src/img/check.png" : "../../src/img/uncheck.png";
  				}
  				Text{
  					anchors.left: img_c1.right;
  					text: " Tiene Historial";
  					height: parent.height;
  					verticalAlignment: Text.AlignVCenter;
                    color: color_base_n8;
  				}
  				MouseArea{anchors.fill: parent; onClicked: tipo_item = 1;}
  			}
  			Item{
  				id: item_c2;
  				anchors.right: parent.right;
  				height: parent.height;
  				width: parent.width * .5;
  				Image{
  					id: img_c2;
  					anchors.verticalCenter: parent.verticalCenter;
  					anchors.left: parent.left;
  					anchors.leftMargin: parent.width * .03;
  					height: parent.height * .72;
  					width: height;
  					source: tipo_item == 2 ? "../../src/img/check.png" : "../../src/img/uncheck.png";
  				}
  				Text{
  					anchors.left: img_c2.right;
  					text: " Nuevo";
  					height: parent.height;
  					verticalAlignment: Text.AlignVCenter;
                    color: root.color_base_n8;
  				}
  				MouseArea{anchors.fill: parent; onClicked: tipo_item = 2;}
  			}
  		}
  		Item{
  			id: row_n3;
  			anchors.top: row_n2.bottom;
  			height: tipo_item == 1 ? (parent.height * .69) : (parent.height * .25);
  			width: parent.width;

  			Item{
  				id: item_m1;
  				anchors.left: parent.left;
  				height: parent.height;
  				width: parent.width;
  				visible: tipo_item == 1 ? true : false;
  				Rectangle{
  					anchors.verticalCenter: parent.verticalCenter;
  					anchors.horizontalCenter: parent.horizontalCenter;
  					height: parent.height * .96;
  					width: parent.width * .96;
  					border.width: 1;
  					border.color: root.color_base_n10;
  					radius: height * .06;
  					TextField {
				        id: txt_busqueda;
				        anchors.top: parent.top;
				        anchors.topMargin: qml_nuevoItem.height * 0.01;
				        font.pixelSize: 18;
				        width: parent.width * 0.96;
				        readOnly: false;
				        text: "";
				        placeholderText: "Buscar";
				        textColor: root.color_base_n2;
				        font.family: root.fuente;
				        anchors.horizontalCenter: parent.horizontalCenter;
				        style: TextFieldStyle {
				            placeholderTextColor: Util.Color.rgba(255, 255, 255, 0.6);
				            background: Rectangle {
				                implicitHeight: qml_nuevoItem.height * 0.06;
				                color: root.color_base_n10;
				                opacity: 0.6;
				                radius: qml_nuevoItem.height * 0.05;
				            }
				        }
				        onTextChanged: {
				            buscarItems(text);
				        }
				    }
				    Item{
				    	anchors.top: txt_busqueda.bottom;
				    	height: (parent.height - txt_busqueda.height) * .96;
				    	width: parent.width;
                        clip: true;
				    	ListView {
				    		id: lst_items;
				    		anchors.verticalCenter: parent.verticalCenter;
				    		anchors.horizontalCenter: parent.horizontalCenter;
				    		height: parent.height * .96;
				    		width: parent.width * .96;
				    		model: model_items;
				    		delegate: Item{
				    			height: qml_nuevoItem.height * .072;
				    			width: parent.width;
				    			Text{
				    				height: parent.height;
				    				width: parent.width * .15;
				    				text: id_ref;
				    				verticalAlignment: Text.AlignVCenter;
				    				horizontalAlignment: Text.AlignHCenter;
                                    color: root.color_base_n1;
                                    font.family: root.fuente;
                                    font.pixelSize: 18;
				    			}
				    			Text{
				    				anchors.left: parent.left;
				    				anchors.leftMargin: parent.width * .21;
				    				height: parent.height;
				    				verticalAlignment: Text.AlignVCenter;
				    				text: nombre;
                                    color: root.color_base_n8;
                                    font.family: root.fuente;
                                    font.pixelSize: 18;
				    			}
				    			Rectangle{anchors.bottom: parent.bottom;height: 1; width: parent.width; color: root.color_base_n10;}
                                MouseArea{
                                    anchors.fill: parent;
                                    onClicked: selItem(id, id_ref, nombre);
                                }
				    		}
				    	}
				    }
  				}
  			}
  			Item{
  				id: item_m2;
  				anchors.right: parent.right;
  				height: parent.height;
  				width: parent.width;
  				visible: tipo_item == 2 ? true : false;
  				Item{
					id: r_n1;
					anchors.top: parent.top;
					height: qml_nuevoItem.height * .072;
					width: parent.width;
					Item{
						anchors.left: parent.left;
						height: parent.height;
						width: parent.width * .3;
						clip: true;
						Text{
							horizontalAlignment: Text.AlignLeft;
							verticalAlignment: Text.AlignVCenter;
							height: parent.height;
							width: parent.width;
							text: " Nombre";
							font.pixelSize: 18;
							font.family: root.fuente;
							color: root.color_base_n8;
						}
					}
					TextField {
						id: txt_nombre;
						anchors.right: parent.right;
						anchors.rightMargin: parent.width * .03;
						anchors.verticalCenter: parent.verticalCenter;
					    width: parent.width * .69;
					    height: parent.height * .72;
					    font.pixelSize: 16;
					    font.family: root.fuente;
					    textColor: root.color_base_n1;
					    style: estiloN1_textField;
					    placeholderText: "Nombre";
					    onTextChanged: {
					    	qml_nuevoItem.nombre_reg = txt_nombre.text;
					    }
					}
				}
				Item{
					id: r_n2;
					anchors.top: r_n1.bottom;
					height: qml_nuevoItem.height * .072;
					width: parent.width;
					Item{
						anchors.left: parent.left;
						height: parent.height;
						width: parent.width * .3;
						clip: true;
						Text{
							horizontalAlignment: Text.AlignLeft;
							verticalAlignment: Text.AlignVCenter;
							height: parent.height;
							width: parent.width;
							text: " Id";
							font.pixelSize: 18;
							font.family: root.fuente;
							color: root.color_base_n8;
						}
					}
					TextField {
						id: txt_id_referencia;
						anchors.right: parent.right;
						anchors.rightMargin: parent.width * .03;
						anchors.verticalCenter: parent.verticalCenter;
					    width: parent.width * .69;
					    height: parent.height * .72;
					    font.pixelSize: 16;
					    font.family: root.fuente;
					    textColor: root.color_base_n1;
					    style: estiloN1_textField;
					    placeholderText: "Id Referencia";
                        onTextChanged: {
                            qml_nuevoItem.id_referencia = txt_id_referencia.text;
                        }
					}
				}
  			}
  		}
  		Item{
  			id: row_n4;
  			anchors.top: row_n3.bottom;
  			height: parent.height * .1;
  			width: parent.width;
  			Item{
				id: r2_n1;
				anchors.top: parent.top;
				height: qml_nuevoItem.height * .072;
				width: parent.width;
				Item{
					anchors.left: parent.left;
					height: parent.height;
					width: parent.width * .3;
					clip: true;
					Text{
						horizontalAlignment: Text.AlignLeft;
						verticalAlignment: Text.AlignVCenter;
						height: parent.height;
						width: parent.width;
						text: " Cantidad";
						font.pixelSize: 18;
						font.family: root.fuente;
						color: root.color_base_n8;
					}
				}
				TextField {
					id: txt_cant_inicial;
					anchors.right: parent.right;
					anchors.rightMargin: parent.width * .03;
					anchors.verticalCenter: parent.verticalCenter;
				    width: parent.width * .69;
				    height: parent.height * .72;
				    font.pixelSize: 16;
				    font.family: root.fuente;
				    textColor: root.color_base_n1;
				    style: estiloN1_textField;
				    placeholderText: "0.00";
                    inputMethodHints: Qt.ImhPreferNumbers;
				}
                /*TextInput{
                    id: txt_cant;
                    anchors.verticalCenter: parent.verticalCenter;
                    anchors.horizontalCenter: parent.horizontalCenter;
                    height: parent.height * .96;
                    width: parent.width * .96;
                    text: cant;
                    verticalAlignment: TextInput.AlignVCenter;
                    horizontalAlignment: TextInput.AlignHCenter;
                    font.pixelSize: 72;
                    color: "#727272";
                    inputMethodHints: Qt.ImhPreferNumbers;
                }*/
			}
  		}
  	}

    Item {
        id: footer;
        anchors.bottom: parent.bottom;
        width: parent.width;
        height: parent.height * .12;
     	Rectangle{height: 1; width: parent.width; color: root.color_base_n10;}

     	Item{
     		anchors.left: parent.left;
     		height: parent.height;
     		width: parent.width * .6;
     		Text{
     			anchors.fill: parent;
     			font.pixelSize: 18;
     			text: "   "+qml_nuevoItem.nombre_reg;
     			verticalAlignment: Text.AlignVCenter;
                color: root.color_base_n3;
     		}
     	}

        Rectangle{
			anchors.verticalCenter: parent.verticalCenter;
			anchors.right: parent.right;
			anchors.rightMargin: parent.width * .03;
			height: parent.height * .72;
			width: parent.width * .36;
			radius: height * .12;
			color: Qt.rgba(0,0,0,0);
			border.color: root.color_base_n1;
			border.width: 1;
			Text{
				anchors.fill: parent;
				verticalAlignment: Text.AlignVCenter;
				horizontalAlignment: Text.AlignHCenter;
				text: "Guardar";
				font.pixelSize: 24;
				color: root.color_base_n2;
				font.bold: true;
			}
			MouseArea{
				anchors.fill: parent;
				onClicked: nuevo();
			}
		}
    }
    Timer{
    	id: timer_cerrar;
    	running: false;
    	repeat: false;
    	interval: tiempo_animacion;
    	onTriggered: {
    		qml_nuevoItem.destroy();
    	}
    }
    Item{
        id: barrera;
        anchors.fill: parent;
        visible: false;
        MouseArea{
            anchors.fill: {

            }
        }
    }
    onIniciar: {
    	/*if(app_manager.INVENTARIOS.getId()){
    		var reg = app_manager.INVENTARIOS.getJson()[app_manager.INVENTARIOS.getId()];
        	header.titulo = reg.fecha+" "+reg.nombre;
    	}*/
      qml_nuevoItem.id_grupo = app_manager.GRUPOS.getId();
    	cargaInicial();
    }
    onFin: {
        qml_nuevoItem.destroy();
    }
    Component.onCompleted: iniciar();
    onDesaparecer: {
        qml_nuevoItem.animar = true;
        qml_nuevoItem.x = qml_nuevoItem.width * -1;
        timer_cerrar.running = true;
    }
    function iniciarCombo(){
        for(var i = 0; i < model_grupos.count; i ++){
            var reg = model_grupos.get(i);
            if(qml_nuevoItem.id_grupo == reg.id)
                combo_grupos.currentIndex = i;
        }
    }
    function cargaInicial(){
        iniciarCombo();
        model_items.clear();
        var json_items = app_manager.items_registrados;
        for(var id in json_items){
            model_items.append({
                "id": id,
                "nombre": json_items[id].nombre,
                "id_ref": json_items[id].id_ref
            });
        }
    }
    function buscarItems(nombre){
        if(nombre == qml_nuevoItem.nombre_reg && nombre != "")
            return;
        model_items.clear();
        var json_items = app_manager.items_registrados;
        for(var id in json_items){
            if((nombre == "") || (json_items[id].nombre.toUpperCase().indexOf(nombre.toUpperCase()) > -1)){
                model_items.append({
                    "id": id,
                    "nombre": json_items[id].nombre,
                    "id_ref": json_items[id].id_ref
                });
            }
        }
    }
    function selItem(id_item, id_ref, nombre){
        qml_nuevoItem.id_item = id_item;
        qml_nuevoItem.id_referencia = id_ref;
        qml_nuevoItem.nombre_reg = nombre;
        txt_busqueda.text = nombre;
    }

    function nuevo(){
      barrera.visible = true;
    	qml_nuevoItem.cant_incial = (txt_cant_inicial.text  * 1.00);
      qml_nuevoItem.id_grupo = model_grupos.get(combo_grupos.currentIndex).id;
      Mensaje.esperar(root, "");
    	app_manager.ITEMS.nuevoDet(qml_nuevoItem.id_item, qml_nuevoItem.id_referencia, qml_nuevoItem.id_grupo, qml_nuevoItem.nombre_reg, qml_nuevoItem.cant_incial, qml_nuevoItem.orden, function(status, msg){
    		Mensaje.hide();
        if(status != 1) {
                Mensaje.error(root, msg);
                barrera.visible = false;
            } else{
                app_manager.GRUPOS.setIndexId(qml_nuevoItem.id_grupo);
                desaparecer();
            }
    	});
    }
    function nuevoGrupo(){
        Mensaje.prompt(root, "Ingrese nombre del Grupo", function(status, value){
            if(status){
              Mensaje.esperar(root, "");
                app_manager.GRUPOS.nuevo(app_manager.CUENTA.id, app_manager.INVENTARIOS.getId(), value, function(status, msg){
                    Mensaje.hide();
                    if(status != 1){
                        Mensaje.error(root, msg);
                    } else {
                      qml_nuevoItem.id_grupo = msg;
                      qml_nuevoItem.iniciarCombo();
                    }
                });
            }
        });
    }
    function buscarGrupo(){

    }
    function aparecer(){
    	qml_nuevoItem.visible = true;
    	qml_nuevoItem.animar = true;
    	qml_nuevoItem.x = 0;
    }
}