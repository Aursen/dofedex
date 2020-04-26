class dofus.graphics.gapi.ui.AskLinkWarning extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
	static var CLASS_NAME = "AskLinkWarning";
	function AskLinkWarning()
	{
		super();
	}
	function __set__text(loc2)
	{
		this._sText = loc2;
		return this.__get__text();
	}
	function __get__text()
	{
		return this._sText;
	}
	function init()
	{
		super.init(false,dofus.graphics.gapi.ui.AskLinkWarning.CLASS_NAME);
	}
	function createChildren()
	{
		this.addToQueue({object:this,method:this.addListeners});
		this.addToQueue({object:this,method:this.initTexts});
	}
	function addListeners()
	{
		this._btnOk.addEventListener("click",this);
	}
	function initTexts()
	{
		this._btnOk.label = this.api.lang.getText("OK");
		this._winBackground.title = this.api.lang.getText("CAUTION");
		this._txtText.text = this._sText;
	}
	function click(loc2)
	{
		if((var loc0 = loc2.target._name) === "_btnOk")
		{
			this.dispatchEvent({type:"ok",params:this.params});
		}
		this.unloadThis();
	}
}
