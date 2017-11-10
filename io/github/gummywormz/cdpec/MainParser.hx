package cdpec;
import cdpec.Section.HeaderFooter;
import cdpec.Section;
import cdpec.Restrictors;
import cdpec.RetrievedData;
import cdpec.RetrievedSection;

import cdpec.ValueRestrictionException;
import cdpec.ParserException;

/**
 * Main parser object
 * @author Paul Alves
 */

using StringTools;
class MainParser
{
	static var decimal_sep = ".";
	var _sections : List<Section>;

	/**
	 * Creates a new section
	 */
	public function new() 
	{
		_sections = new List<Section>();
	}
	
	/**
	 * Adds a section to this parser
	 * @param	s The section to add
	 */
	public function addSection(s:Section)
	{
		_sections.add(s);
	}
	
	/**
	 * Sets the decimal separator to use for StrictFloatRestrictors
	 * The default is .
	 * @see io.github.gummywormz.Restrictors
	 * @param	d The decimal separator character to set
	 */
	public function setDecimalSeparator(d:String)
	{
		decimal_sep = d;
	}
	
	/**
	 * Parses the given file / String, separated by line breaks
	 * @param	f The string to parse
	 * @return A list of RetrievedSections
	 */
	public function parseFile(f:String):List<RetrievedSection>
	{
		var lSplit = ~/\r\n?|\n/g; //split on new lines
		var list = lSplit.split(f);
		var dataList = new List<RetrievedSection>();
		var isSection = false; //controls the current section
		var baseSec = new Section({header:"Null",footer:"Null"});
		var rSection = new RetrievedSection("Null", "Null");
		var lineCount = 0;
		for (e in list)
		{
			lineCount+=1;
			if (e.startsWith("@") || e.trim() == "" || e.startsWith("#")) { continue; } //skip comment lines and such
			//trace("test");
			if(isSection)
			{
					//trace("Started parsing section");
			        var dat = e.split("=");
					//trace(dat[0] + " " + baseSec.getFooter());
					if (dat[0] == baseSec.getFooter())
					{
						//trace("Ending parsing section");
						isSection = false;
						dataList.add(rSection);
					}else{
					//trace(dat[0] + " " + dat[1]);
					if (dat[1] == null) { throw new ParserException('Invalid data encountered @ line $lineCount. Check for missing equals signs and invalid headers or footers.'); }
			        for(d in baseSec.returnList())
			        {
							//trace("Looking at value " + d.name + " " + dat[0]);
			                if(dat[0] == d.name)
			                {
						switch(d.restrictor)
						{
							case RegexRestrictor(regex):
								if(!regex.match(dat[1])){throw new ValueRestrictionException("Value " + dat[1] + " failed RegexRestrictor" );}
								rSection.addData(new RetrievedData(dat[0],"String",dat[1]));
								break;
							case EndingRestrictor(end):
								if(!dat[1].endsWith(end)){throw new ValueRestrictionException("Value " + dat[1] + " failed EndingRestrictor" );}
								rSection.addData(new RetrievedData(dat[0],"String",dat[1]));
								break;
							case StartingRestrictor(start):
								if(!dat[1].startsWith(start)){throw new ValueRestrictionException("Value " + dat[1] + " failed StartingRestrictor" );}
								rSection.addData(new RetrievedData(dat[0],"String",dat[1]));
								break;
							case NoRestrictor:
								rSection.addData(new RetrievedData(dat[0],"String",dat[1]));
								break;
							case IntegerRestrictor:
								var data = Std.parseInt(dat[1]);//TODO: figure out what happens when it cant be parsed since it doesn't throw an exception??
								if (data == null || (data == 0 && dat[1] != "0")) { throw new ValueRestrictionException("Value " + dat[1] + " failed IntegerRestrictor"); }
								rSection.addData(new RetrievedData(dat[0], "Integer", dat[1]));
								break;
							case StrictFloatRestrictor:
								if(dat[1].indexOf(decimal_sep) == -1){throw new ValueRestrictionException("Value " + dat[1] + " failed StrictFloatRestrictor");}
							case LaxFloatRestrictor:
								var dataX = Std.parseFloat(dat[1]);//TODO: figure out what happens when it cant be parsed since it doesn't throw an exception??
								if ((dataX == 0.0 && dat[1] != "0.0")) { throw new ValueRestrictionException("Value " + dat[1] + " failed LaxFloatRestrictor"); }
								rSection.addData(new RetrievedData(dat[0], "Float", dat[1]));
								break;
						}
			                }
							
							
			        }
			}}
			for (s in _sections) //find the section the file is referencing
			{
				//trace("Looking at section H:" + s.getHeader() + " E:" + e);
				if (s.getHeader() == e)
				{
					//trace("Found section");
					rSection = new RetrievedSection(s.getHeader(),s.getFooter());
					isSection = true;
					baseSec = s;
					break;
				}
			}
		}
		return dataList;
	}

}
