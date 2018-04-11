////////////////////////////////////////////////////////////////////////////
// Manejador de menu contextual para radgrid
////////////////////////////////////////////////////////////////////////////
function handlerRadClick(idCtrlMenu,idClientIndex) {
    var idMenu = idCtrlMenu;
    this.click = function (sender, eventArgs) {
        var evt = eventArgs.get_domEvent();
        if (evt.target.tagName == "INPUT" || evt.target.tagName == "A") {
            return;
        }

        var index = eventArgs.get_itemIndexHierarchical();
        if (idClientIndex != undefined) {
            document.getElementById("radGridClickedRowIndex").value = index;
        }

        sender.get_masterTableView().selectItem(sender.get_masterTableView().get_dataItems()[index].get_element(), true);

        menu = $telerik.findControl(document, idMenu);

        if (menu != null) {
            menu.show(evt);
            evt.cancelBubble = true;
            evt.returnValue = false;
        }

        if (evt.stopPropagation) {
            evt.stopPropagation();
            evt.preventDefault();
        }

    }
}

////////////////////////////////////////////////////////////////////////////
//  Destruye los elementos de un radgrid con paginacion
////////////////////////////////////////////////////////////////////////////
function _destroyTree2(element) {
    if (element.nodeType === 1) {
        var childNodes = element.childNodes;
        for (var i = childNodes.length - 1; i >= 0; i--) {
            var node = childNodes[i];
            if (node.nodeType === 1) {
                if (node.dispose && typeof (node.dispose) === "function") {
                    node.dispose();
                }
                else if (node.control && typeof (node.control.dispose) === "function") {
                    node.control.dispose();
                }
                var behaviors = Sys.UI.Behavior.getBehaviors(node);
                for (var j = behaviors.length - 1; j >= 0; j--) {
                    behaviors[j].dispose();
                }
                this._destroyTree(node);
            }
        }
    }
}

Sys.WebForms.PageRequestManager.getInstance()._destroyTree = _destroyTree2
