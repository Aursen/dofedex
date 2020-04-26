class dofus.graphics.gapi.ui.FightsInfos extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
	static var CLASS_NAME = "FightsInfos";
	function FightsInfos()
	{
		super();
	}
	function __get__fights()
	{
		return this._eaFights;
	}
	function addFightTeams(loc2, loc3, loc4)
	{
		var loc6 = this._eaFights.findFirstItem("id",loc2);
		if(loc6.index != -1)
		{
			var loc5 = loc6.item;
		}
		loc5.addPlayers(1,loc3);
		loc5.addPlayers(2,loc4);
		this.showTeamInfos(true,this._oSelectedFight);
	}
	function init()
	{
		super.init(false,dofus.graphics.gapi.ui.FightsInfos.CLASS_NAME);
	}
	function callClose()
	{
		this.unloadThis();
		return true;
	}
	function createChildren()
	{
		this._eaFights = new ank.utils.();
		this.showTeamInfos(false);
		this.addToQueue({object:this,method:this.initTexts});
		this.addToQueue({object:this,method:this.addListeners});
		this.addToQueue({object:this,method:this.initData});
		this.addToQueue({object:this.api.network.Fights,method:this.api.network.Fights.getList});
		this.setMovieClipColor(this._mcSquare1,dofus.Constants.TEAMS_COLOR[0]);
		this.setMovieClipColor(this._mcSquare2,dofus.Constants.TEAMS_COLOR[1]);
	}
	function initTexts()
	{
		this._btnClose2.label = this.api.lang.getText("CLOSE");
		this._btnJoin.label = this.api.lang.getText("JOIN_SMALL");
		this._winBg.title = this.api.lang.getText("CURRENT_FIGTHS");
		this._dgFights.columnsNames = [this.api.lang.getText("FIGHTERS_COUNT"),this.api.lang.getText("DURATION")];
		this._lblPlayers.text = this.api.lang.getText("FIGHTERS");
		this._txtSelectFight.text = this.api.lang.getText("SELECT_FIGHT_FOR_SPECTATOR");
		if(this._lblTeam1Level.text != undefined)
		{
			this._lblTeam1Level.text = "";
		}
		if(this._lblTeam2Level.text != undefined)
		{
			this._lblTeam2Level.text = "";
		}
	}
	function addListeners()
	{
		this._btnClose.addEventListener("click",this);
		this._btnClose2.addEventListener("click",this);
		this._btnJoin.addEventListener("click",this);
		this._dgFights.addEventListener("itemSelected",this);
		this._lstTeam1.addEventListener("itemSelected",this);
		this._lstTeam2.addEventListener("itemSelected",this);
	}
	function initData()
	{
		this._dgFights.dataProvider = this._eaFights;
	}
	function showTeamInfos(loc2, loc3)
	{
		this._lblTeam1Level._visible = loc2;
		this._lblTeam2Level._visible = loc2;
		this._lstTeam1._visible = loc2;
		this._lstTeam2._visible = loc2;
		this._mcBackTeam._visible = loc2;
		this._mcSquare1._visible = loc2;
		this._mcSquare2._visible = loc2;
		this._txtSelectFight._visible = !loc2;
		this._btnJoin.enabled = loc2;
		if(loc2)
		{
			this._lblTeam1Level.text = this.api.lang.getText("LEVEL") + " " + loc3.team1Level;
			this._lblTeam2Level.text = this.api.lang.getText("LEVEL") + " " + loc3.team2Level;
			this._lstTeam1.dataProvider = loc3.team1Players;
			this._lstTeam2.dataProvider = loc3.team2Players;
		}
	}
	function click(loc2)
	{
		switch(loc2.target._name)
		{
			case "_btnClose":
			case "_btnClose2":
				this.callClose();
				break;
			case "_btnJoin":
				this.api.network.GameActions.joinChallenge(this._oSelectedFight.id);
				this.callClose();
		}
	}
	function itemSelected(loc2)
	{
		if((var loc0 = loc2.target._name) !== "_dgFights")
		{
			if(loc2.row.item.type == "player")
			{
				var loc3 = loc2.row.item.name;
				if(this.api.datacenter.Player.isAuthorized && Key.isDown(Key.SHIFT))
				{
					var loc4 = "";
					var loc5 = false;
					for(var k in this._lstTeam1.dataProvider)
					{
						var loc6 = this._lstTeam1.dataProvider[k].name;
						if(loc6 == loc3)
						{
							loc5 = true;
						}
						loc4 = loc4 + (loc6 + ",");
					}
					if(!loc5)
					{
						loc4 = "";
						for(var k in this._lstTeam2.dataProvider)
						{
							var loc7 = this._lstTeam2.dataProvider[k].name;
							if(loc7 == loc3)
							{
								loc5 = true;
							}
							loc4 = loc4 + (loc7 + ",");
						}
					}
					if(loc5)
					{
						loc4 = loc4.substring(0,loc4.length - 1);
						this.api.kernel.GameManager.showTeamAdminPopupMenu(loc4);
					}
				}
				else
				{
					this.api.kernel.GameManager.showPlayerPopupMenu(undefined,loc3);
				}
			}
		}
		else
		{
			this._oSelectedFight = loc2.row.item;
			if(this._oSelectedFight.hasTeamPlayers)
			{
				this.showTeamInfos(true,this._oSelectedFight);
			}
			else
			{
				this.api.network.Fights.getDetails(this._oSelectedFight.id);
				this.showTeamInfos(false);
			}
		}
	}
}
