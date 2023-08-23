### Installation using API  
*WARNING:*  This is a rather dirty hack if there is no other chance   

First, connect to Server
````
    set %rccon=##class(%Net.DB.DataSource).CreateConnection(serverIP, serverPORT, namespace, username, password)
    set %rccdb=%rccon.CreateIris()
````
Now we prepare the routine %ZX.int
````
set %rccline="x(%rcc) try {return $xecute(%rcc)} catch %rcc {return %rcc.DisplayString()}"
set
do %rccdb.Set($h,"ROUTINE","%ZX",0)
do %rccdb.Set(1,"ROUTINE","%ZX",0,0)
do %rccdb.Set(%rccline,"ROUTINE","%ZX",0,1)

;; the dirty hack
set b=$lb(192,158,177,106,105,162,215,100,1,0,10,9,0,1,1,0,0,0,1,0,184,0,0,0,1,0,127,0,40,181,47,253,32,184,181,3,0,68,6,192,158,177,106,105,162,215,100,1,0,10,9,0,32,68,0,225,32,231,129,32,16,16,253,230,253,127,247,15,253,124,166,32,253,120,114,253,127,184,0,0,238,13,68,105,115,112,108,97,121,83,116,114,105,110,103,4,37,114,99,99,1,120,0,0,0,0,21,0,1,0,27,0,1,0,249,255,0,0,0,0,1,0,2,0,13,0,1,0,235,64,72,112,0,254,255,1,0,0,0,6,0,96,17,185,63,16,33,231,29,132,35,56,186,230,19)
;; should have 155 elements
set o=""
for i=1:1:$LL(b) set o=o_$c($li(b,i))
;; stringlenght must be 155 !
do %rccdb.Set(o,"rOBJ","%ZX")
set line1="set %rccx=##class(%Routine).%OpenId(""%ZX.INT"") quit %rccx"
set line2="o 2 u 2 set %rccy=%rccx.Compile() c 2 quit %rccy"
set sc=%rccdb.Function("%ZX","",line1) zw sc
set sc=%rccdb.Function("%ZX","",line2) zw sc
````
Now %ZX interface is ready to be used
