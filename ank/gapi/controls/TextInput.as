class ank.gapi.controls.TextInput extends ank.gapi.controls.Label
{
	static var CLASS_NAME = "TextInput";
	var _sTextfiledType = "input";
	var _sRestrict = "none";
	var _nMaxChars = -1;
	function TextInput()
	{
		super();
	}
	function __set__restrict(loc2)
	{
		this._sRestrict = loc2 != "none"?loc2:null;
		if(this._tText != undefined)
		{
			this.setRestrict();
		}
		return this.__get__restrict();
	}
	function __get__restrict()
	{
		return this._tText.restrict;
	}
	function __set__maxChars(loc2)
	{
		this._nMaxChars = loc2 != -1?loc2:null;
		if(this._tText != undefined)
		{
			this.setMaxChars();
		}
		return this.__get__maxChars();
	}
	function __get__maxChars()
	{
		return this._tText.maxChars;
	}
	function __get__focused()
	{
		return eval(Selection.getFocus()) == this._tText;
	}
	function __set__tabIndex(loc2)
	{
		this._tText.tabIndex = loc2;
		return this.__get__tabIndex();
	}
	function __get__tabIndex()
	{
		return this._tText.tabIndex;
	}
	function __set__tabEnabled(loc2)
	{
		this._tText.tabEnabled = loc2;
		return this.__get__tabEnabled();
	}
	function __get__tabEnabled()
	{
		return this._tText.tabEnabled;
	}
	function __set__password(loc2)
	{
		this._tText.password = loc2;
		return this.__get__password();
	}
	function __get__password()
	{
		return this._tText.password;
	}
	function setFocus()
	{
		if(this._tText == undefined)
		{
			this.addToQueue({object:this,method:function()
			{
				Selection.setFocus(this._tText);
			}});
		}
		else
		{
			Selection.setFocus(this._tText);
		}
	}
	function createChildren()
	{
		super.createChildren();
		this.setRestrict();
		this.setMaxChars();
	}
	function setEnabled()
	{
		if(this._bEnabled)
		{
			this._tText.type = "input";
		}
		else
		{
			this._tText.type = "dynamic";
		}
	}
	function setRestrict()
	{
		this._tText.restrict = this._sRestrict;
	}
	function setMaxChars()
	{
		this._tText.maxChars = this._nMaxChars;
	}
}
