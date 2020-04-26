class dofus.graphics.gapi.controls.JobViewer extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
	static var CLASS_NAME = "JobViewer";
	var _sCurrentTab = "Characteristics";
	function JobViewer()
	{
		super();
	}
	function __set__job(loc2)
	{
		this._oJob = loc2;
		this.addToQueue({object:this,method:this.layoutContent});
		return this.__get__job();
	}
	function init()
	{
		super.init(false,dofus.graphics.gapi.controls.JobViewer.CLASS_NAME);
	}
	function createChildren()
	{
		this._lblNoTool._visible = false;
		this._mcPlacer._visible = false;
		this.addToQueue({object:this,method:this.initTexts});
		this.addToQueue({object:this,method:this.addListeners});
	}
	function initTexts()
	{
		this._lblXP.text = this.api.lang.getText("EXPERIMENT");
		this._lblSkill.text = this.api.lang.getText("SKILLS");
		this._lblTool.text = this.api.lang.getText("TOOL");
		this._lblNoTool.text = this.api.lang.getText("NO_TOOL_JOB");
		this._btnTabCharacteristics.label = this.api.lang.getText("CHARACTERISTICS");
		this._btnTabCrafts.label = this.api.lang.getText("RECEIPTS");
		this._btnTabOptions.label = this.api.lang.getText("OPTIONS");
	}
	function addListeners()
	{
		this._btnTabCharacteristics.addEventListener("click",this);
		this._btnTabCrafts.addEventListener("click",this);
		this._btnTabOptions.addEventListener("click",this);
	}
	function layoutContent()
	{
		if(this._oJob == undefined)
		{
			return undefined;
		}
		this.setCurrentTab(this._sCurrentTab);
		this._lstSkills.removeMovieClip();
		var loc2 = this.api.datacenter.Player.currentJobID == this._oJob.id;
		this._ldrIcon.contentPath = this._oJob.iconFile;
		this._lblName.text = this._oJob.name;
		this._lblLevel.text = this.api.lang.getText("LEVEL") + " " + this._oJob.level;
		this._pbXP.minimum = this._oJob.xpMin;
		this._pbXP.maximum = this._oJob.xpMax;
		this._pbXP.value = this._oJob.xp;
		this._mcXP.onRollOver = function()
		{
			this._parent._parent.gapi.showTooltip(new ank.utils.(this._parent._oJob.xp).addMiddleChar(this._parent.api.lang.getConfigText("THOUSAND_SEPARATOR"),3) + " / " + new ank.utils.(this._parent._oJob.xpMax).addMiddleChar(this._parent.api.lang.getConfigText("THOUSAND_SEPARATOR"),3),this,-10);
		};
		this._mcXP.onRollOut = function()
		{
			this._parent._parent.gapi.hideTooltip();
		};
		var loc3 = this._oJob.skills;
		if(loc3.length != 0)
		{
			loc3.sortOn("skillName");
			this._lstSkills.dataProvider = loc3;
		}
		if(loc2)
		{
			this._lblNoTool._visible = false;
			this._itvItemViewer._visible = true;
			var loc4 = this.api.datacenter.Player.Inventory.findFirstItem("position",1).item;
			this._itvItemViewer.itemData = loc4;
		}
		else
		{
			this._lblNoTool._visible = true;
			this._itvItemViewer._visible = false;
		}
	}
	function showCraftViewer(loc2)
	{
		if(loc2)
		{
			var loc3 = this.attachMovie("CraftViewer","_cvCraftViewer",20);
			loc3._x = this._mcPlacer._x;
			loc3._y = this._mcPlacer._y;
			loc3.job = this._oJob;
		}
		else
		{
			this._cvCraftViewer.removeMovieClip();
		}
	}
	function showOptionViewer(loc2)
	{
		if(loc2)
		{
			var loc3 = this.attachMovie("JobOptionsViewer","_jovJobOptionsViewer",20);
			loc3._x = this._mcPlacer._x;
			loc3._y = this._mcPlacer._y;
			loc3.job = this._oJob;
		}
		else
		{
			this._jovJobOptionsViewer.removeMovieClip();
		}
	}
	function updateCurrentTabInformations()
	{
		switch(this._sCurrentTab)
		{
			case "Characteristics":
				this.showOptionViewer(false);
				this.showCraftViewer(false);
				break;
			case "Crafts":
				this.showOptionViewer(false);
				this.showCraftViewer(true);
				break;
			case "Options":
				this.showCraftViewer(false);
				this.showOptionViewer(true);
		}
	}
	function setCurrentTab(loc2)
	{
		var loc3 = this["_btnTab" + this._sCurrentTab];
		var loc4 = this["_btnTab" + loc2];
		loc3.selected = true;
		loc3.enabled = true;
		loc4.selected = false;
		loc4.enabled = false;
		this._sCurrentTab = loc2;
		this.updateCurrentTabInformations();
	}
	function click(loc2)
	{
		switch(loc2.target._name)
		{
			case "_btnTabCharacteristics":
				this.setCurrentTab("Characteristics");
				break;
			case "_btnTabCrafts":
				this.setCurrentTab("Crafts");
				break;
			case "_btnTabOptions":
				this.setCurrentTab("Options");
		}
	}
}
