// First, let's create a short helper function to get the database connection
function getDatabase() {
     return LocalStorage.openDatabaseSync("DbLucumaFull", "1.0", "DbLucumaFull", 100000);
}
 
// At the start of the application, we can initialize the tables we need if they haven't been created yet
function initialize() {
  var db = getDatabase();
  db.transaction(
      function(tx) {
          // Create the settings table if it doesn't already exist
          // If the table exists, this is skipped
          tx.executeSql('CREATE TABLE IF NOT EXISTS settings(setting TEXT UNIQUE, value TEXT)');
  });
}
 
// This function is used to write a setting into the database
function setSetting(setting, value) {
   // setting: string representing the setting name (eg: “username”)
   // value: string representing the value of the setting (eg: “myUsername”)
   var db = getDatabase();
   var res = "";
  
   db.transaction(function(tx) {
        var rs = tx.executeSql('INSERT OR REPLACE INTO settings VALUES (?,?);', [setting,value]);
              //console.log(rs.rowsAffected)
              if (rs.rowsAffected > 0) {
                res = "OK";
              } else {
                res = "Error";
              }
        }
  );
  // The function returns “OK” if it was successful, or “Error” if it wasn't
  return res;
}
// This function is used to retrieve a setting from the database
function getSetting(setting) {
   var db = getDatabase();
   var res="";
   db.transaction(function(tx) {
     var rs = tx.executeSql('SELECT value FROM settings WHERE setting=?;', [setting]);
     if (rs.rows.length > 0) {
          res = rs.rows.item(0).value;
     } else {
         res = "Unknown";
     }
  })
  // The function returns “Unknown” if the setting was not found in the database
  // For more advanced projects, this should probably be handled through error codes
  return res
}
initialize();


function parseData(data)
{
  var response = '';
  for(var id in data)
    response += id+'='+data[id]+'&';
  response = response.substring(0, response.length - 1);
  return response;
}

function cerrarEn(tiempo)
{
  var component = Qt.createComponent('Cerrar.qml'), cerrar;
  if(component.status == Component.Ready)
  {
    cerrar = component.createObject(root);
    cerrar.tiempo = tiempo;
    cerrar.ejecuta();
  }
}
function randomString(cant) {
  var chars = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXTZabcdefghiklmnopqrstuvwxyz";
  var string_length = cant;
  var randomstring = '';
  for (var i=0; i < string_length; i++) {
    var rnum = Math.floor(Math.random() * chars.length);
    randomstring += chars.substring(rnum,rnum+1);
  }
  return randomstring;
}
function completarDecimales(numero, cant)
{
  numero += "";
  var completo = numero;
  var decimales = numero.split(".");
  if(decimales.length > 1)
  {
    for(var i = decimales[1].length; i < cant; i ++)
    {
      completo += "0";
    }
  } else {
    completo += ".";
    for(var i = 0; i < cant; i ++)
    {
      completo += "0";
    }
  }
  return completo;
}
var TIPO_DIS = ""; //tablet || mobile

var INFO_01 = "";
var INFO_02 = "";
var INFO_03 = "";
var INFO_04 = "";
var INFO_05 = "";
var INFO_06 = "";
var INFO_07 = "";

var RECUERDAME = "";
var INGRESAR = "";
var TXT_INI_1 = "";
var TXT_INI_2 = "";
var CANCELAR = "";
var AGREGAR_BOTELLA = "";
var ORDEN = "";
var INVENTARIAR = "";
var VOLVER = "";
var GUARDAR = "";
var ENVIAR = "";
var REPETIR = "";
var SUCURSALES = "";
var MENU = "";
var AGREGAR = "";
var MODIFICAR = "";
var BORRAR = "";
var LM_TXT1 = "";
var LM_TXT2 = "";
var LM_TXT3 = "";
var MENU_1 = "";
var MENU_2 = "";
var MENU_3 = "";
var MENU_4 = "";
var BUSQUEDA = "";
var SOPORTE = "";
var CATEGORIAS = "";
var CONSULTA = "";
var S_OP1 = "";
var S_OP2 = "";
var S_OP3 = "";
var USUARIO = "";
var NOMBRE = "";
var MEDIDA = "";
var TIPO = "";
var CAPTURAR = "";

var idiomas = {
  'español': {
    'RECUERDAME': 'Recuerdame',
    'INGRESAR': 'Ingresar',
    'TXT_INI_1': 'Todavia no tienes una cuenta?',
    'TXT_INI_2': 'Registrate',
    'CANCELAR': 'Cancelar',
    'AGREGAR_BOTELLA': 'Agregar Botella',
    'ORDEN': 'ORDEN',
    'INVENTARIAR': 'INVENTARIAR',
    'VOLVER': 'Volver',
    'GUARDAR': 'Guardar',
    'ENVIAR': 'Enviar',
    'REPETIR': 'Repetir',
    'SUCURSALES': 'SUCURSALES',
    'MENU': 'Menu',
    'AGREGAR': 'Agregar',
    'MODIFICAR': 'Modificar',
    'BORRAR': 'Borrar',
    'LM_TXT1': 'Mililitros:',
    'LM_TXT2': 'Shots 1.5 Oz:',
    'LM_TXT3': 'Botella(s)',
    'MENU_3': 'TICKET DE SOPORTE',
    'MENU_4': 'SALIR',
    'BUSQUEDA': 'Búsqueda',
    'SOPORTE': 'Soporte',
    'CATEGORIAS': 'Categorias',
    'CONSULTA': 'Consulta',
    'S_OP1': 'Técnica',
    'S_OP2': 'Pagos',
    'S_OP3': 'Comercial',
    'USUARIO': 'Usuario',
    'NOMBRE': 'Nombre',
    'MEDIDA': 'Medida',
    'TIPO': 'Tipo',
    'CAPTURAR': 'Capturar imagen'
  }, 
  'ingles': {
    'RECUERDAME': 'Remember',
    'INGRESAR': 'Sign in',
    'TXT_INI_1': 'Do not have an account ?',
    'TXT_INI_2': 'Register',
    'CANCELAR': 'Cancel',
    'AGREGAR_BOTELLA': 'Add Bottle',
    'ORDEN': 'ORDER',
    'INVENTARIAR': 'INVENTORY',
    'VOLVER': 'Back',
    'GUARDAR': 'Save',
    'ENVIAR': 'Send',
    'REPETIR': 'Repeat',
    'SUCURSALES': 'BRANCHES',
    'MENU': 'Menu',
    'AGREGAR': 'Add',
    'MODIFICAR': 'Modify',
    'BORRAR': 'Delete',
    'SOPORTE': 'Support',
    'CATEGORIAS': 'Categories',
    'CONSULTA': 'Consultation',
    'S_OP1': 'Tecnica',
    'S_OP2': 'Payments',
    'S_OP3': 'Commercial',
    'USUARIO': 'User',
    'NOMBRE': 'Name',
    'MEDIDA': 'Measure',
    'TIPO': 'Type',
    'CAPTURAR': 'Capture picture'
  }
}
var infos = {
  'español': {
    'INFO_01': 'src/img/Info-screen-1-%tipo%.jpg',
    'INFO_02': 'src/img/Info-screen-2-%tipo%.jpg',
    'INFO_03': 'src/img/Info-screen-3-%tipo%.jpg',
    'INFO_04': 'src/img/Info-screen-4-%tipo%.jpg',
    'INFO_05': 'src/img/Info-screen-5-%tipo%.jpg',
    'INFO_06': 'src/img/Info-screen-6-%tipo%.jpg',
    'INFO_07': 'src/img/Info-screen-7-%tipo%.jpg'
  }, 
  'ingles': {
    'INFO_01': 'src/img/Info-screen-1-%tipo%.jpg',
    'INFO_02': 'src/img/Info-screen-2-%tipo%.jpg',
    'INFO_03': 'src/img/Info-screen-3-%tipo%.jpg',
    'INFO_04': 'src/img/Info-screen-4-%tipo%.jpg',
    'INFO_05': 'src/img/Info-screen-5-%tipo%.jpg',
    'INFO_06': 'src/img/Info-screen-6-%tipo%.jpg',
    'INFO_07': 'src/img/Info-screen-7-%tipo%.jpg'
  }
}
function establecerTipoDis() {
  //console.log('Datos del dispositivo');
  //console.log(JSON.stringify(WURFL));
  //TIPO_DIS = WURFL.is_mobile ? "mobile" : "tablet";
  var WURFL = getSetting('datos_dis');
  if(WURFL != "Unknown") {
    //console.log('Datos reales WURFL');
    //console.log(WURFL);
    WURFL = JSON.parse(WURFL);
    TIPO_DIS = WURFL.is_mobile ? "mobile" : "tablet";
  } else {
    TIPO_DIS = "tablet";
  }
}
function establecerIdioma(idioma){
  establecerTipoDis();
  setSetting('idioma', idioma);

  INFO_01 = infos[idioma]['INFO_01'].replace('%tipo%', TIPO_DIS);
  INFO_02 = infos[idioma]['INFO_02'].replace('%tipo%', TIPO_DIS);
  INFO_03 = infos[idioma]['INFO_03'].replace('%tipo%', TIPO_DIS);
  INFO_04 = infos[idioma]['INFO_04'].replace('%tipo%', TIPO_DIS);
  INFO_05 = infos[idioma]['INFO_05'].replace('%tipo%', TIPO_DIS);
  INFO_06 = infos[idioma]['INFO_06'].replace('%tipo%', TIPO_DIS);
  INFO_07 = infos[idioma]['INFO_07'].replace('%tipo%', TIPO_DIS);

  RECUERDAME = idiomas[idioma]['RECUERDAME'];
  INGRESAR = idiomas[idioma]['INGRESAR'];
  TXT_INI_1 = idiomas[idioma]['TXT_INI_1'];
  TXT_INI_2 = idiomas[idioma]['TXT_INI_2'];
  CANCELAR = idiomas[idioma]['CANCELAR'];
  AGREGAR_BOTELLA = idiomas[idioma]['AGREGAR_BOTELLA'];
  ORDEN = idiomas[idioma]['ORDEN'];
  INVENTARIAR = idiomas[idioma]['INVENTARIAR'];
  VOLVER = idiomas[idioma]['VOLVER'];
  GUARDAR = idiomas[idioma]['GUARDAR'];
  ENVIAR = idiomas[idioma]['ENVIAR'];
  REPETIR = idiomas[idioma]['REPETIR'];
  SUCURSALES = idiomas[idioma]['SUCURSALES'];
  MENU = idiomas[idioma]['MENU'];
  AGREGAR = idiomas[idioma]['AGREGAR'];
  MODIFICAR = idiomas[idioma]['MODIFICAR'];
  BORRAR = idiomas[idioma]['BORRAR'];
  LM_TXT1 = idiomas[idioma]['LM_TXT1'];
  LM_TXT2 = idiomas[idioma]['LM_TXT2'];
  LM_TXT3 = idiomas[idioma]['LM_TXT3'];
  MENU_3 = idiomas[idioma]['MENU_3'];
  MENU_4 = idiomas[idioma]['MENU_4'];
  BUSQUEDA = idiomas[idioma]['BUSQUEDA'];
  SOPORTE = idiomas[idioma]['SOPORTE'];
  CATEGORIAS = idiomas[idioma]['CATEGORIAS'];
  CONSULTA = idiomas[idioma]['CONSULTA'];
  S_OP1 = idiomas[idioma]['S_OP1'];
  S_OP2 = idiomas[idioma]['S_OP2'];
  S_OP3 = idiomas[idioma]['S_OP3'];
  USUARIO = idiomas[idioma]['USUARIO'];
  NOMBRE = idiomas[idioma]['NOMBRE'];
  MEDIDA = idiomas[idioma]['MEDIDA'];
  TIPO = idiomas[idioma]['TIPO'];
  CAPTURAR = idiomas[idioma]['CAPTURAR'];
}
initialize();
var idioma = getSetting('idioma');
idioma = idioma == 'Unknown' ? 'español' : idioma;
establecerIdioma(idioma);
