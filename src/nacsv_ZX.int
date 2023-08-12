Class oex.map Extends %Persistent [ Final ]
{

Property url As %String(MAXLEN = "") [ Private ];

Property label As %String(MAXLEN = "");

Property author As %String(MAXLEN = "");

Property technology As %String(MAXLEN = "");

Property zpmmodul As %String(MAXLEN = "");

Property review As %Boolean [ InitialExpression = 0 ];

Property page As %Integer [ InitialExpression = 0 ];

Property stars As %Numeric(SCALE = 1);

Property version As %String(MAXLEN = "");

Property lastupdate As %Date;

Method lastupdateSet(Arg As %String) As %Status [ ServerOnly = 1 ]
{
  Set i%lastupdate=$ZDH(Arg,3)
  Quit $$$OK
}

Property IRIS As %Boolean [ Calculated, SqlComputeCode = { set {*}=($zcvt({technology},"U")["IRIS") }, SqlComputed ];

Property ZPM As %Boolean [ Calculated, SqlComputeCode = { set {*}=$S({zpmmodul}/1={zpmmodul}:{zpmmodul},1:{zpmmodul}]"") }, SqlComputed ];

Property xurl As %String(MAXLEN = "") [ Calculated, SqlComputeCode = {set {*}="https://openexchange.intersystems.com"_{url}}, SqlComputed ];

Index url On url [ Unique ];

Index pgn On page [ Type = bitmap ];

Index aut On author [ Type = bitmap ];

ClassMethod unique(url As %String) As %Boolean
{
  quit '..urlExists(url)
}
ClassMethod total(maxpage As %Integer = 25) As %Integer [ SqlName = TOTAL, SqlProc ]
{
#; job ##class(oex.map).total()::0  w $ZC,!,$T
#; special for background job on demo server		
  if $I["null" {
    kill ^SPOOL(1)
    open 2:1 use 2
		}

	&sql(CALL oex.CLEAR())
	if SQLCODE quit +SQLCODE
	write $zdt($h,3)," start load directory",!
	set ec=0
	for pn=1:1:maxpage {
		&sql(CALL oex.PAGE(:pn))
		write $zdt($h,3)," directory page ",pn,!
		if 'SQLCODE set ec=0 continue
		if $i(ec)>10 return +SQLCODE
		if $i(pn,-1) continue		
	}
	write $zdt($h,3)," start load details",!
	set sc=0
#;
#; I have to set res to something because Code Quality Check just
#; doesn't understand how host variables in embedded SQL work  !!!	
#; WHAT A NONSENSE !
	set res=""
	for  {
		set ec=0
		&SQL(SELECT top 1 id, oex.DETAIL(id) into:res() 
			FROM oex.map WHERE author is NULL)
		if SQLCODE=100 set ec=0 quit	
		if 'SQLCODE&%ROWCOUNT  {
			write $zdt($h,3)," load details "_res(1)_$s(ec:" retry "_ec,1:""),!
			set ec=0
			if $i(sc) continue
			}
		else {
			if $i(ec)< 10 continue
			zw  b  continue 
		    }
		}
	write $zdt($h,3)," loaded "_sc_" details",!	
	quit $$$OK
}
Storage Default
{
<Data name="mapDefaultData">
<Value name="1">
<Value>url</Value>
</Value>
<Value name="2">
<Value>label</Value>
</Value>
<Value name="3">
<Value>author</Value>
</Value>
<Value name="4">
<Value>technology</Value>
</Value>
<Value name="5">
<Value>zpmmodul</Value>
</Value>
<Value name="6">
<Value>review</Value>
</Value>
<Value name="7">
<Value>page</Value>
</Value>
<Value name="8">
<Value>stars</Value>
</Value>
<Value name="9">
<Value>version</Value>
</Value>
<Value name="10">
<Value>lastupdate</Value>
</Value>
</Data>
<DataLocation>^oex.mapD</DataLocation>
<DefaultData>map1DefaultData</DefaultData>
<IdLocation>^oex.mapD</IdLocation>
<IndexLocation>^oex.mapI</IndexLocation>
<StreamLocation>^oex.mapS</StreamLocation>
<Type>%Storage.Persistent</Type>
}
}
                                    
