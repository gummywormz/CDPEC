package io.github.gummywormz;

/**
 * Provides custom types for use in this parser
 * @author Paul Alves
 */

 
/**
* Enum for value restrictors. These are applied at parse time and throw
* a "ValueRestrictionException" if the value doesn't apply
* NoRestrictor - No restrictions
* IntegerRestrictor - Value must be an integer
* LaxFloatRestrictor - Value must be a decimal number. This implies IntegerRestrictor
* StrictFloatRestrictor - Value must be a decimal number. Fails if the value does not physically have a decimal separator
* EndingRestrictor - Value must end in the following string. @param end The string to check
* StartingRestrictor - Value must start with the following string. @param start The string to check
* RegexRestrictor - Value must match the provided regex. @param regex the regex to check
*/
enum Restrictors 
{
	NoRestrictor;
	IntegerRestrictor;
	LaxFloatRestrictor;
	StrictFloatRestrictor;
	EndingRestrictor(end:String);
	StartingRestrictor(start:String);
	RegexRestrictor(regex:EReg);
}

/**
* Describes a header and footer for this section
* @param header The header / opening tag
* @param footer The footer / closing tag
*/
typedef HeaderFooter = 
{
	var header : String;
	var footer : String;
}
	
	
/**
* Describes a value
* @param name The name of the value
* @param restrictor The restrictor
*/
typedef ValueInfo = 
{
	var name : String;
	var restrictor : Restrictors;
}