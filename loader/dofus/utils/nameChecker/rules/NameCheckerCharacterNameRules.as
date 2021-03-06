class dofus.utils.nameChecker.rules.NameCheckerCharacterNameRules extends dofus.utils.ApiElement implements dofus.utils.nameChecker.rules.INameCheckerRules
{
	var MIN_NAME_LENGTH = 2;
	var MAX_NAME_LENGTH = 20;
	var NUMBER_OF_ALLOWED_DASHES = 1;
	var ALLOW_SPACES = false;
	var NO_DASHES_ON_INDEXES = [0,1];
	var FIRST_CHAR_MUST_BE_UPPERCASE = true;
	var NO_UPPERCASE_AFTER_THE_FIRST = true;
	var UPPERCASE_ALLOWED_AFTER = ["-"];
	var CANNOT_END_WITH_UPPERCASE = true;
	var PROHIBED_WORDS_STRICTLY_EQUAL = [];
	var PROHIBED_WORDS_INSIDE = ["XELOR","IOP","FECA","ENIRIPSA","SADIDA","ECAFLIP","ENUTROF","PANDAWA","SRAM","CRA","OSAMODAS","SACRIEUR","DROP","MULE"];
	var PROHIBED_WORDS_ON_BEGINNING = [];
	var PROHIBED_WORDS_ON_ENDING = [];
	var AT_LEAST_X_VOWELS = 1;
	var AT_LEAST_X_CONSONANTS = 0;
	var REPETING_CHAR_MAX = 2;
	function NameCheckerCharacterNameRules()
	{
		super();
	}
	function getMinNameLength()
	{
		return this.MIN_NAME_LENGTH;
	}
	function getMaxNameLength()
	{
		return this.MAX_NAME_LENGTH;
	}
	function getNumberOfAllowedDashes()
	{
		return this.NUMBER_OF_ALLOWED_DASHES;
	}
	function getIsAllowingSpaces()
	{
		return this.ALLOW_SPACES;
	}
	function getNoDashesOnTheseIndexes()
	{
		return this.NO_DASHES_ON_INDEXES;
	}
	function getIfFirstCharMustBeUppercase()
	{
		return this.FIRST_CHAR_MUST_BE_UPPERCASE;
	}
	function getIfNoCharAfterTheFirstMustBeUppercase()
	{
		return this.NO_UPPERCASE_AFTER_THE_FIRST;
	}
	function getCharAllowingUppercase()
	{
		return this.UPPERCASE_ALLOWED_AFTER;
	}
	function getIfCannotEndWithUppercase()
	{
		return this.CANNOT_END_WITH_UPPERCASE;
	}
	function getStrictlyEqualsProhibedWords()
	{
		return this.PROHIBED_WORDS_STRICTLY_EQUAL;
	}
	function getContainingProhibedWords()
	{
		var var2 = new Array();
		var var3 = 0;
		while(var3 < dofus.Constants.GUILD_ORDER.length)
		{
			var var4 = new ank.utils.(this.api.lang.getClassText(dofus.Constants.GUILD_ORDER[var3]).sn);
			var var5 = var4.replace(["é","à","â"],["e","a","a"]).toUpperCase();
			if(var5 == undefined)
			{
				return this.PROHIBED_WORDS_INSIDE;
			}
			var2.push(var5);
			var3 = var3 + 1;
		}
		var2.push("MULE");
		var2.push("DROP");
		return var2;
	}
	function getBeginningProhibedWords()
	{
		return this.PROHIBED_WORDS_ON_BEGINNING;
	}
	function getEndingProhibedWords()
	{
		return this.PROHIBED_WORDS_ON_ENDING;
	}
	function getMinimumVowelsCount()
	{
		return this.AT_LEAST_X_VOWELS;
	}
	function getMinimumConsonantsCount()
	{
		return this.AT_LEAST_X_CONSONANTS;
	}
	function getMaxRepetitionForOneChar()
	{
		return this.REPETING_CHAR_MAX;
	}
}
