class dofus.graphics.gapi.controls.questionviewer.QuestionViewerAnswerItem extends ank.gapi.core.UIBasicComponent
{
	function QuestionViewerAnswerItem()
	{
		super();
	}
	function setValue(var2, var3, var4)
	{
		if(var2)
		{
			this._mcRound._visible = true;
			var var5 = var4.label;
			if(dofus.Constants.DEBUG)
			{
				var5 = var5 + " (" + var4.id + ")";
			}
			this._txtResponse.text = var5;
		}
		else if(this._txtResponse.text != undefined)
		{
			this._mcRound._visible = false;
			this._txtResponse.text = "";
		}
	}
	function init()
	{
		super.init(false);
		this._mcRound._visible = false;
	}
	function size()
	{
		super.size();
	}
}
