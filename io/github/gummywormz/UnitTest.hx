package io.github.gummywormz;

import io.github.gummywormz.Section;
import io.github.gummywormz.MainParser;
import io.github.gummywormz.Restrictors;
import io.github.gummywormz.ValueRestrictionException;

/**
 * Tests the parser
 * @author Paul Alves
 */
class UnitTest
{

	static function main()
	{
		trace("Testing a normal file...");
		var s = new Section( { header:"[START_TEST_DATA]", footer:"[END_TEST_DATA]" } );
		s.addValue( { name:"TESTSTRING", restrictor:Restrictors.NoRestrictor } );
		s.addValue( { name:"TESTINT", restrictor:Restrictors.IntegerRestrictor } );
		s.addValue( { name:"TESTFLOATSTRICT", restrictor:Restrictors.StrictFloatRestrictor } );
		s.addValue( { name:"TESTFLOATLAX", restrictor:Restrictors.LaxFloatRestrictor } );
		s.addValue( { name:"TESTEND", restrictor:Restrictors.EndingRestrictor(".png") } );
		s.addValue( { name:"TESTSTART", restrictor:Restrictors.StartingRestrictor("base64") } );
		s.addValue( { name:"TESTREGEX", restrictor:Restrictors.RegexRestrictor( ~/magic/ ) } );
		
		var p = new MainParser();
		p.addSection(s);
		
		var file = "[START_TEST_DATA]\n" + "TESTSTRING=Value\n" + "TESTINT=8\n"
					+ "TESTFLOATSTRICT=8.8\n" + "TESTFLOATLAX=5.2\n" 
					+ "TESTEND=img.png\n" + "TESTSTART=base64...\n"
					+ "TESTREGEX=magicalelevators\n"
					+ "[END_TEST_DATA]";
		
		var got = p.parseFile(file);
		
		for (d in got)
		{
			trace(d.getHeader());
			
			for (d2 in d.returnList())
			{
				trace(d2.getName()+"="+d2.getValueAsString() + " (Type was " + 
					  d2.getTypeAsString() + ")");
					  
			}
			
			trace(d.getFooter());
			
		}
		
		trace("Testing integerrestrictor...");
		file = "[START_TEST_DATA]\n" + "TESTINT=lel\n"
					+ "[END_TEST_DATA]";
					
		try p.parseFile(file)
		catch (e : ValueRestrictionException) trace("Pass");
		
		trace("Testing strictfloatrestrictor...");
		file = "[START_TEST_DATA]\n" + "TESTFLOATSTRICT=9\n"
					+ "[END_TEST_DATA]";
					
		try p.parseFile(file)
		catch (e : ValueRestrictionException) trace("Pass");
		
		trace("Testing endingrestrictor...");
		file = "[START_TEST_DATA]\n" + "TESTEND=no\n"
					+ "[END_TEST_DATA]";
					
		try p.parseFile(file)
		catch (e : ValueRestrictionException) trace("Pass");
		
		trace("Testing startingrestrictor...");
		file = "[START_TEST_DATA]\n" + "TESTSTART=no\n"
					+ "[END_TEST_DATA]";
					
		try p.parseFile(file)
		catch (e : ValueRestrictionException) trace("Pass");
		
		trace("Testing regexrestrictor...");
		file = "[START_TEST_DATA]\n" + "TESTREGEX=no\n"
					+ "[END_TEST_DATA]";
					
		try p.parseFile(file)
		catch (e : ValueRestrictionException) trace("Pass");
		
		trace("Testing malformed file...");
		file = "[START_TEST_DATA]\n" + "TESTREGEX|no\n"
					+ "[END_TEST_DATA]";
					
		try p.parseFile(file)
		catch (e : ParserException) trace("Pass");
		
		trace('Done');
	}
}