sap.ui.define(["sap/ui/core/mvc/Controller"],function(t){"use strict";return t.extend("zca12nav01.controller.View1",{onInit:function(){this._fnGetService=sap.ushell&&sap.ushell.Container&&sap.ushell.Container.getService;this._oCrossAppNavigation=this._fn+
GetService&&this._fnGetService("CrossApplicationNavigation")},onTableItemClick:function(t){let e=t.getSource().getBindingContext();let i=e.getProperty("Carrid");if(this._oCrossAppNavigation){let t=this._oCrossAppNavigation.toExternal({target:{semanticObj+
ect:"CLA12",action:"navto"},params:{pCarrid:i}})}}})});                                                                                                                                                                                                        