class dofus.graphics.battlefield.EffectIcon extends MovieClip
{
	static var COLOR_PLUS = 255;
	static var COLOR_MINUS = 16711680;
	static var COLOR_FACTOR = 65280;
	function EffectIcon()
	{
		super();
		_global.subtrace("yahoo");
		this.initialize(this._sOperator,this._nQte);
	}
	function __set__operator(loc2)
	{
		this._sOperator = loc2;
		return this.__get__operator();
	}
	function __set__qte(loc2)
	{
		this._nQte = loc2;
		return this.__get__qte();
	}
	function initialize(loc2, loc3)
	{
		switch(loc2)
		{
			case "-":
				this.attachMovie("Icon-","_mcOp",10,{_x:1,_y:1});
				var loc4 = new Color(this._mcbackground);
				loc4.setRGB(dofus.graphics.battlefield.EffectIcon.COLOR_MINUS);
				break;
			case "+":
				this.attachMovie("Icon+","_mcOp",10,{_x:1,_y:1});
				var loc5 = new Color(this._mcbackground);
				loc5.setRGB(dofus.graphics.battlefield.EffectIcon.COLOR_PLUS);
				break;
			case "*":
				this.attachMovie("Icon*","_mcOp",10,{_x:1,_y:1});
				var loc6 = new Color(this._mcbackground);
				loc6.setRGB(dofus.graphics.battlefield.EffectIcon.COLOR_FACTOR);
		}
	}
}
