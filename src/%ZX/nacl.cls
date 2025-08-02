Class %ZX.nacl [ Abstract ]
{
ClassMethod x(%rcc) As %String
{
	try {
		return $xecute(%rcc)}
 	catch %rcc {
	 	return %rcc.DisplayString()}
}

ClassMethod zv() As %String
{  quit $zv  }
}