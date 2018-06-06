import QtQuick 2.1
import QtQuick.LocalStorage 2.0
import QtQuick.Controls 1.2
import QtQuick.Controls.Styles 1.4

import "MyComponents"
import "MyComponents/js/mensajes.js" as Mensaje
import "../js/db.js" as Db
import "inventarios"
import "vistas"

Image {
	id: qml_maestro;
	height: root.height;
    width: root.width;

    property int index: -1;
    property int page: 1;
    property int tiempo_animacion: 300;
    property bool animar_n1: false;
    property bool animar_n2: false;
    property variant ins_memoria;


    property variant pages: ["inventarios/Inventarios.qml", "vistas/VistaN1.qml"];

    signal setIndex(int nIndex, variant callback);
    signal next(variant callback);
    signal back(variant callback);
    signal iniciar;
    signal fin;

    Rectangle{
        id: item_n1;
        height: parent.height;
        width: parent.width;
        Behavior on x {NumberAnimation {duration: animar_n1 ? tiempo_animacion : 0;}}
    }
    Rectangle{
        id: item_n2;
        height: parent.height;
        width: parent.width;
        x: item_n1.width;
        visible: false;
        Behavior on x {NumberAnimation{duration: animar_n2 ? tiempo_animacion : 0;}}
    }
    Timer {
        id: timer_cerrar;
        running: false;
        repeat: false;
        interval: qml_maestro.tiempo_animacion
        onTriggered: {
            qml_maestro.fin();
            qml_maestro.fin.connect(qml_maestro.ins_memoria.fin);
        }
    }
    

    onSetIndex: {
        qml_maestro.animar_n1 = false;
        qml_maestro.animar_n2 = false;
        page = 1;
        index = nIndex;
        var component = Qt.createComponent(pages[nIndex]), ins_qml;
        if(component.status == Component.Ready)
        {
            ins_qml = component.createObject(item_n1);
            ins_qml.height = item_n1.height;
            ins_qml.width = item_n1.width;
            ins_qml.x = 0;
            item_n1.visible = true;
            item_n1.x = 0;
            item_n2.visible = false;
            if(callback != null)
                callback();
        } else {
            console.log("no se pudo crear setIndex");
        }
        qml_maestro.fin();
        qml_maestro.fin.connect(ins_qml.fin);
        qml_maestro.animar_n1 = true;
        qml_maestro.animar_n2 = true;
    }
    onNext: {
        if(prepararNext()){
            animar_n1 = animar_n2 = true;
            timer_cerrar.running = true;
            if(page == 1){
                item_n2.visible = true;
                item_n1.x = -item_n1.width;
                item_n2.x = 0;
                page = 2;
            } else if(page == 2){
                item_n1.visible = true;
                item_n2.x = -item_n2.width;
                item_n1.x = 0;
                page = 1;
            }
            if(callback != null)
                callback();
        }
    }
    onBack: {
        if(prepararBack()){
            animar_n1 = animar_n2 = true;
            timer_cerrar.running = true;
            if(page == 1){
                item_n2.visible = true;
                item_n1.x = item_n1.width;
                item_n2.x = 0;
                page = 2;
            } else if(page == 2){
                item_n1.visible = true;
                item_n2.x = item_n2.width;
                item_n1.x = 0;
                page = 1;
            }
            if(callback != null)
                callback();
        }
    }
    function prepararNext(){
        if((index < -1) || ((index + 1) > pages.length)){
            return false;
        }
        var component = Qt.createComponent(pages[index + 1]), ins_qml;
        if(component.status == Component.Ready)
        {
            if(page == 1){
                animar_n2 = false;
                item_n2.visible = false;
                item_n2.x = item_n1.width;
                ins_qml = component.createObject(item_n2);
                ins_qml.height = item_n2.height;
                ins_qml.width = item_n2.width;
            } else if(page == 2){
                animar_n1 = false;
                item_n1.visible = false;
                item_n1.x = item_n1.width;
                ins_qml = component.createObject(item_n1);
                ins_qml.height = item_n1.height;
                ins_qml.width = item_n1.width;
                
            }
            qml_maestro.iniciar.connect(ins_qml.iniciar);
            qml_maestro.ins_memoria = ins_qml;
            index = (index + 1);
            return true;
        }
        return false; 
    }
    function prepararBack(){
        if((index < 0) || (index == 0)){
            return false;
        }
        var component = Qt.createComponent(pages[index - 1]), ins_qml;
        if(component.status == Component.Ready)
        {
            if(page == 1){
                animar_n2 = false;
                item_n2.visible = false;
                item_n2.x = -item_n1.width;
                ins_qml = component.createObject(item_n2);
                ins_qml.height = item_n2.height;
                ins_qml.width = item_n2.width;
            } else if(page == 2){
                animar_n1 = false;
                item_n1.visible = false;
                item_n1.x = -item_n1.width;
                ins_qml = component.createObject(item_n1);
                ins_qml.height = item_n1.height;
                ins_qml.width = item_n1.width;
            }
            qml_maestro.iniciar.connect(ins_qml.iniciar);
            qml_maestro.ins_memoria = ins_qml;
            index = (index - 1);
            return true;
        }
        return false; 
    }

    

    Component.onCompleted: {
        setIndex(qml_maestro.index, null);
        app_manager.INVENTARIOS.resetModel();
        root.iniciar.connect(qml_maestro.iniciar);
    }
}