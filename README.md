Native API for IRIS  is missing an option to run a simple   
Command in ObjectScript as you do from the console or a terminal.   
This add-on allows to submit some command line and receive a reply.   

The NativeAPI function always requires to have a reply value   
So take care to terminate your line with any QUIT <value>   
to serve the underlying method. Even if it makes no sense.    
e.g.   **SET ^MyGlobal="I was here" *QUIT 1***

NativAPI Connection opens a partition as a terminal or a console will do.  
So once connected you can deposit there also all kinds of     
local variables or PPG as you would in a terminal or console session.  
 
### Prerequisites for demo   
Make sure you have [git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git) and [Docker desktop](https://www.docker.com/products/docker-desktop) installed.   

### Installation in docker using IPM   
Clone/git pull the repo into any local directory   
```
git https://github.com/rcemper/native-api-command-line-extention.git
```
Run the IRIS container with your project: 
```
docker-compose up -d --build
```
### Installation using SQL
Enter Management Portal / System Explorer / SQL   
Define this procedure   
````
CREATE PROCEDURE %Zrcc.X()  
LANGUAGE OBJECTSCRIPT  
{   
 set %rcc=##class(%Routine).%New("%ZX.int")  
 set %rccline="x(%rcc) try {return $xecute(%rcc)} catch %rcc {return %rcc.DisplayString()}"  
 do %rcc.WriteLine(%rccline)   
 do %rcc.Save()   
 quit %rcc.Compile()   
}   
````
and execute it    
````
CALL %Zrcc.X()
````
### Installation using API  
*WARNING:*  This is a rather dirty hack if there is no other chance   

First conect to Server
````
    set %rccon=##class(%Net.DB.DataSource).CreateConnection(serverIP, serverPORT, namespace, username, password)
    set %rccdb=%rccon.CreateIris()
````
Now we prepare the routine %ZX.int
````
set %rccline="x(%rcc) try {return $xecute(%rcc)} catch %rcc {return %rcc.DisplayString()}"
do %rccdb.Set($h,"ROUTINE","%ZX",0)
do %rccdb.Set(1,"ROUTINE","%ZX",0,0)
do %rccdb.Set(%rccline,"ROUTINE","%ZX",0,1)
set sc=%rccdb.ClassMethodValue("%Routine","CompileList","%ZX.int")
````

## How to Test it
Use the related client demo for testing

[Article in DC](https://community.intersystems.com/post/remote-global-listing-using-nativeapi-objectscript-2)  

