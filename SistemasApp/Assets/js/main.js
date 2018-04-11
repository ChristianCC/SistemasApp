function mostrarPanel(panel, callback) {
    $(panel).show("blind");
    if (callback != undefined) {
        callback();
    }
}
function ocultarPanel(panel,callback) {
    $(panel).hide("blind");
    if (callback != undefined) {
        callback();
    }
}

function closePanel(sender) {    
    ocultarPanel("#" + $(sender).parents(".panel")[0].id);
}

function toogleMenuRigth() {
    $("#btn-sidebar-rigth").click();
}