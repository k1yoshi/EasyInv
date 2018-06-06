import QtQuick 2.2
import QtQuick.LocalStorage 2.0
import QtQuick.Window 2.2
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.1
import QtQuick.Dialogs 1.2


import "qml/MyComponents"
import "qml/MyComponents/js/mensajes.js" as Mensaje
import "js/db.js" as Db
import "js/util.js" as Util
import "js/easyInv.js" as Easy

import "qml"
import "qml/Items/"

ApplicationWindow
{
    id: root;
    visible: true;
    height: 600;
    width: 400;   

    property variant app_manager: new Easy.EasyInv(root);
    property variant message_espera: null;
    property alias fuente: font_JelleeRoman.name;

    property string color_base_n1: "#178bd4";
    property string color_base_n2: "#0068aa";
    property string color_base_n3: "#2c7dc9";
    property string color_base_n4: "#577ac1";
    property string color_base_n5: "#e8f3fb";
    property string color_base_n6: "#5b8de4";
    property string color_base_n7: "#57a3ae";
    property string color_base_n8: "#054a89";
    property string color_base_n9: "#22a0cc";
    property string color_base_n10: "#8bc5ea";
    

    property string color_texto_1: "#0B3861";
    property string color_texto_2: "#2E9AFE";

    property double alto_header: height * .09;


    property int id_cuenta;

    signal iniciar;

    ListModel{id: model_inv; }
    ListModel{id: model_det_grupo; }
    ListModel{id: model_vistaN1; }
    ListModel{id: model_grupos; }
    ListModel{id: model_det; }

    FontLoader {id: font_JelleeRoman; source: "fuentes/KhmerUI.ttf";}
    Loader
    {
        id: contenedor_qml;
        height: parent.height;
        width: parent.width;
        source: "qml/Login.qml";
        Keys.onReleased: {
            /*if (event.key == Qt.Key_Back && stackView.depth > 2) {
                Qt.inputMethod.hide();
                event.accepted = true;
            } else {
                event.accepted = false;
            }*/
        }
        onLoaded:
        {
            Qt.inputMethod.hide();
        }
    }

    onClosing: 
    {
        //close.accepted = false;
    }

    function enviarJson(){
        var tipo = app_manager.CUENTA.tipo_envio == 1 ? "POST" : "GET";
        var httpRequest = new XMLHttpRequest(); 
        var parametros = "datos="+JSON.stringify(getJson())
        httpRequest.responseType = "text";
        httpRequest.open(tipo, app_manager.CUENTA.servidor, true);
        httpRequest.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
        httpRequest.setRequestHeader("Content-length", parametros.length);
        httpRequest.setRequestHeader("Connection", "close");
        httpRequest.onreadystatechange = function(){
            if (httpRequest.readyState == 4) {
                if (httpRequest.status == 200) 
                    Mensaje.aviso(root, "Los datos se han enviado correctamente")
                else 
                    Mensaje.error(root, "No se pudo enviar los datos al servidor");
            }
        };
        httpRequest.send(parametros);
    }
    function getJson(){
        var reg_inv = app_manager.INVENTARIOS.getJson()[app_manager.INVENTARIOS.getId()];
        var json_resumen = app_manager.MODELO_N1.getJson();
        var json_items = app_manager.items_registrados;
        var nuevo_json = {};
        for(var id in json_resumen){
            nuevo_json[json_items[json_resumen[id].id_item].id_ref] = json_resumen[id];
        }
        var json_enviar = {
            "hora": reg_inv.hora,
            "fecha": reg_inv.fecha,
            "items": nuevo_json
        }
        return json_enviar;
    }

    //Jr. Agua Marina Urb San Hilarion 154
}
