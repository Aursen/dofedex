class ank.gapi.controls.Loader extends ank.gapi.core.UIBasicComponent
{
	static var CLASS_NAME = "Loader";
	var _bEnabled = false;
	var _bAutoLoad = true;
	var _bScaleContent = false;
	var _bCenterContent = false;
	var _sURL = "";
	var _sURLFallback = "";
	var _bForceReload = false;
	function Loader()
	{
		super();
	}
	function __set__enabled(loc2)
	{
		super.__set__enabled(loc3);
		return this.__get__enabled();
	}
	function __set__scaleContent(loc2)
	{
		this._bScaleContent = loc2;
		return this.__get__scaleContent();
	}
	function __get__scaleContent()
	{
		return this._bScaleContent;
	}
	function __set__autoLoad(loc2)
	{
		this._bAutoLoad = loc2;
		return this.__get__autoLoad();
	}
	function __get__autoLoad()
	{
		return this._bAutoLoad;
	}
	function __set__centerContent(loc2)
	{
		this._bCenterContent = loc2;
		return this.__get__centerContent();
	}
	function __get__centerContent()
	{
		return this._bCenterContent;
	}
	function __set__contentParams(loc2)
	{
		this._oParams = loc2;
		if(this._oParams.frame)
		{
			this.frame = this._oParams.frame;
		}
		return this.__get__contentParams();
	}
	function __get__contentParams()
	{
		return this._oParams;
	}
	function __set__contentPath(sURL)
	{
		this._sURL = sURL;
		if(this._bAutoLoad)
		{
			this.load();
		}
		return this.__get__contentPath();
	}
	function __get__contentPath()
	{
		return this._sURL;
	}
	function __set__fallbackContentPath(loc2)
	{
		this._sURLFallback = loc2;
		return this.__get__fallbackContentPath();
	}
	function __get__fallbackContentPath()
	{
		return this._sURLFallback;
	}
	function __set__forceReload(loc2)
	{
		this._bForceReload = loc2;
		return this.__get__forceReload();
	}
	function __get__forceReload()
	{
		return this._bForceReload;
	}
	function __get__bytesLoaded()
	{
		return this._nBytesLoaded;
	}
	function __get__bytesTotal()
	{
		return this._nBytesTotal;
	}
	function __get__percentLoaded()
	{
		var loc2 = Math.round(this.bytesLoaded / this.bytesTotal * 100);
		loc2 = !_global.isNaN(loc2)?loc2:0;
		return loc2;
	}
	function __get__content()
	{
		return this.holder_mc.content_mc;
	}
	function __get__holder()
	{
		return this.holder_mc;
	}
	function __get__loaded()
	{
		return this._bLoaded;
	}
	function __set__frame(loc2)
	{
		this._sFrame = loc2;
		this.content.gotoAndStop(loc2);
		this.size();
		return this.__get__frame();
	}
	function forceNextLoad()
	{
		delete this._sPrevURL;
	}
	function init()
	{
		super.init(false,ank.gapi.controls.Loader.CLASS_NAME);
		if(this._bScaleContent == undefined)
		{
			this._bScaleContent = true;
		}
		this._bInited = true;
		this._nBytesLoaded = 0;
		this._nBytesTotal = 0;
		this._bLoaded = false;
		this._mvlLoader = new MovieClipLoader();
		this._mvlLoader.addListener(this);
	}
	function createChildren()
	{
		this.createEmptyMovieClip("holder_mc",10);
		if(this._bAutoLoad && this._sURL != undefined)
		{
			this.load();
		}
	}
	function size()
	{
		super.size();
		if(this.holder_mc.content_mc != undefined)
		{
			if(this._sFrame != undefined && this._sFrame != "")
			{
				this.frame = this._sFrame;
			}
			if(this._bScaleContent)
			{
				var loc3 = this.holder_mc.content_mc._width;
				var loc4 = this.holder_mc.content_mc._height;
				var loc5 = loc3 / loc4;
				var loc6 = this.__width / this.__height;
				if(loc5 == loc6)
				{
					this.holder_mc._width = this.__width;
					this.holder_mc._height = this.__height;
				}
				else if(loc5 > loc6)
				{
					this.holder_mc._width = this.__width;
					this.holder_mc._height = this.__width / loc5;
				}
				else
				{
					this.holder_mc._width = this.__height * loc5;
					this.holder_mc._height = this.__height;
				}
				var loc7 = this.holder_mc.content_mc.getBounds();
				this.holder_mc.content_mc._x = - loc7.xMin;
				this.holder_mc.content_mc._y = - loc7.yMin;
				this.holder_mc._x = (this.__width - this.holder_mc._width) / 2;
				this.holder_mc._y = (this.__height - this.holder_mc._height) / 2;
			}
			if(this._bCenterContent)
			{
				this.holder_mc._x = this.__width / 2;
				this.holder_mc._y = this.__height / 2;
			}
		}
	}
	function setEnabled()
	{
		if(this._bEnabled)
		{
			this.onRelease = function()
			{
				this.dispatchEvent({type:"click"});
			};
		}
		else
		{
			delete this.onRelease;
		}
	}
	function load()
	{
		if(this._sPrevURL == undefined && this._sURL == "")
		{
			return undefined;
		}
		if(!this._bForceReload && (this._sPrevURL == this._sURL || this._sURL == undefined || this.holder_mc == undefined))
		{
			return undefined;
		}
		this._visible = false;
		this._bLoaded = false;
		this._sPrevURL = this._sURL;
		this.holder_mc.content_mc.removeMovieClip();
		if(this._sURL.toLowerCase().indexOf(".swf") != -1)
		{
			if(this.holder_mc.content_mc == undefined)
			{
				this.holder_mc.createEmptyMovieClip("content_mc",1);
			}
			this._mvlLoader.loadClip(this._sURL,this.holder_mc.content_mc);
		}
		else
		{
			this.holder_mc.attachMovie(this._sURL,"content_mc",1,this._oParams);
			this.onLoadComplete(this.holder_mc.content_mc);
			this.onLoadInit(this.holder_mc.content_mc);
		}
	}
	function onLoadError(loc2)
	{
		if(this._sURLFallback != "")
		{
			this._sURL = this._sURLFallback;
			this._sURLFallback = "";
			this.load();
		}
		else
		{
			this.dispatchEvent({type:"error",target:this,clip:loc2});
		}
	}
	function onLoadProgress(loc2, loc3, loc4)
	{
		this._nBytesLoaded = loc3;
		this._nBytesTotal = loc4;
		this.dispatchEvent({type:"progress",target:this,clip:loc2});
	}
	function onLoadComplete(loc2)
	{
		this._bLoaded = true;
		this.dispatchEvent({type:"complete",clip:loc2});
	}
	function onLoadInit(loc2)
	{
		this.size();
		this._visible = true;
		this.dispatchEvent({type:"initialization",clip:loc2});
	}
}
