package io.github.gummywormz;
import io.github.gummywormz.Section.HeaderFooter;
import io.github.gummywormz.Section;
import io.github.gummywormz.Restrictors;
import io.github.gummywormz.RetrievedData;
import io.github.gummywormz.RetrievedSection;
/**
 * Main parser object
 * @author Paul Alves
 */

using StringTools;
class MainParser
{
	static var decimal_sep = ".";
	var _sections : List<Section>;

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

	public function parseFile(f:String)
	{
		var lSplit = ~/\n?\r/; //split on new lines
		var list = lSplit.split(f);
		var dataList = new List<RetrievedSection>();
		var isSection = false; //controls the current section
		var baseSec = new Section({header:"Null",footer:"Null"});
		var rSection = new RetrievedSection("Null","Null");
		for (e in list)
		{
			if (e.startsWith("@") || e.trim() == "" || e.startsWith("#")) { continue; } //skip comment lines and such
			
			if(isSection)
			{
			        var dat = e.split("=");
			        for(d in baseSec.returnList())
			        {
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
								rSection.addData(new RetrievedData(dat[0], "Integer", dat[1]));
								break;
							case StrictFloatRestrictor:
								if(dat[1].indexOf(decimal_sep) == -1){throw new ValueRestrictionException("Value " + dat[1] + " failed StrictFloatRestrictor");}
							case LaxFloatRestrictor:
								var dataX = Std.parseFloat(dat[1]);//TODO: figure out what happens when it cant be parsed since it doesn't throw an exception??
								rSection.addData(new RetrievedData(dat[0], "Float", dat[1]));
								break;
						}
			                }
							if (dat[0] == baseSec.getFooter())
							{
								isSection = false;
								dataList.add(rSection);
							}
			        }
			}
			for (s in _sections) //find the section the file is referencing
			{
				if (s.getHeader() == e)
				{
					rSection = new RetrievedSection(s.getHeader(),s.getFooter());
					isSection = true;
					baseSec = s;
					break;
				}
			}
		}
		return dataList;
	}
	
	static function main(){}
}
