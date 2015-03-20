package io.github.gummywormz;
import io.github.gummywormz.Section.HeaderFooter;
/**
 * Main parser object
 * @author Paul Alves
 */

using StringTools;
class MainParser
{
	
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

	public function parseFile(f:String)
	{
		var lSplit = ~/\n?\r/; //split on new lines
		var list = lSplit.split(f);
		var dataList = new List<RetrievedSection>();
		var isSection = false; //controls the current section
		var baseSec;
		var rSection;
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
							case RegexRestrictor(regex:EReg):
								if(!regex.match(dat[1])){throw new ValueRestrictionException("Value " + dat[1] + " failed RegexRestrictor" );}
								rSection.addData(new RetrievedData(dat[0],"String",dat[1]));
								break;
							case EndingRestrictor(end:String):
								if(!dat[1].endsWith(end)){throw new ValueRestrictionException("Value " + dat[1] + " failed EndingRestrictor" );}
								rSection.addData(new RetrievedData(dat[0],"String",dat[1]));
								break;
							case StartingRestrictor(start:String):
								if(!dat[1].startsWith(start)){throw new ValueRestrictionException("Value " + dat[1] + " failed StartingRestrictor" );}
								rSection.addData(new RetrievedData(dat[0],"String",dat[1]));
								break;
							case NoRestrictor:
								rSection.addData(new RetrievedData(dat[0],"String",dat[1]));
								break;
							case IntegerRestrictor:
								var data = Std.parseInt(dat[1]);//TODO: figure out what happens when it cant be parsed since it doesn't throw an exception??
								rSection.addData(new RetrievedData(dat[0],"Integer",data))
								break;
							case StrictFloatRestrictor:
								if(dat[1].indexOf(".") == -1){throw new ValueRestrictionException("Value " + dat[1] + " failed StrictFloatRestrictor");}
							case LaxFloatRestrictor:
								var data = Std.parseFloat(dat[1]);//TODO: figure out what happens when it cant be parsed since it doesn't throw an exception??
								rSection.addData(new RetrievedData(dat[0],"Float",data))
								break;
							
							
						}
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
	}
}
