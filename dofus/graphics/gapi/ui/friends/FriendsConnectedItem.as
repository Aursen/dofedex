class dofus.graphics.gapi.ui.friends.FriendsConnectedItem extends ank.gapi.core.UIBasicComponent
{
	function FriendsConnectedItem()
	{
		super();
	}
	function __set__list(loc2)
	{
		this._mcList = loc2;
		return this.__get__list();
	}
	function setValue(loc2, loc3, loc4)
	{
		if(loc2)
		{
			this._oItem = loc4;
			if(loc4.account != undefined && !this._mcList._parent._parent.api.config.isStreaming)
			{
				this._lblName.text = loc4.account + " (" + loc4.name + ")";
			}
			else
			{
				this._lblName.text = loc4.name;
			}
			if(loc4.level != undefined)
			{
				this._lblLevel.text = loc4.level;
			}
			else
			{
				this._lblLevel.text = "";
			}
			this._mcFight._visible = loc4.state == "IN_MULTI";
			this._ldrGuild.contentPath = dofus.Constants.GUILDS_MINI_PATH + loc4.gfxID + ".swf";
			if(loc4.alignement != -1)
			{
				this._ldrAlignement.contentPath = dofus.Constants.ALIGNMENTS_MINI_PATH + loc4.alignement + ".swf";
			}
			else
			{
				this._ldrAlignement.contentPath = "";
			}
			this._btnRemove._visible = true;
		}
		else if(this._lblName.text != undefined)
		{
			this._lblName.text = "";
			this._lblLevel.text = "";
			this._ldrAlignement.contentPath = "";
			this._mcFight._visible = false;
			this._ldrGuild.contentPath = "";
			this._btnRemove._visible = false;
		}
	}
	function init()
	{
		super.init(false);
		this._mcFight._visible = false;
		this._btnRemove._visible = false;
	}
	function createChildren()
	{
		this.addToQueue({object:this,method:this.addListeners});
	}
	function addListeners()
	{
		this._btnRemove.addEventListener("click",this);
	}
	function click(loc2)
	{
		if(this._oItem.account != undefined)
		{
			this._mcList._parent._parent.removeFriend("*" + this._oItem.account);
		}
		else
		{
			this._mcList._parent._parent.removeFriend(this._oItem.name);
		}
	}
}
