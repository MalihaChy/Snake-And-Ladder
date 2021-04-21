drop database link host_link;
create database link host_link
 connect to system identified by "123456"
 using '(DESCRIPTION =
       (ADDRESS_LIST =
         (ADDRESS = (PROTOCOL = TCP)
(HOST = 192.168.2.102)
(PORT = 1521))
       )
       (CONNECT_DATA =
         (SID = XE)
       )
     )'
; 