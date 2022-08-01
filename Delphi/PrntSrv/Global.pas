unit Global;

interface

const
  ConnectionString = 'Provider=Microsoft.Jet.OLEDB.4.0; Data Source= ';
  LimitDBName      = 'Limits.mdb';

const
  ConStrSource = 'Provider=Microsoft.Jet.OLEDB.4.0;User ID=Admin;Data Source=';
  ConStrP1  = ';Mode=Share Deny None;Extended Properties="";Jet OLEDB:System database="";';
  ConStrP2  = 'Jet OLEDB:Registry Path="";Jet OLEDB:Database Password="";';
  ConStrP3  = 'Jet OLEDB:Engine Type=5;Jet OLEDB:Database Locking Mode=1;';
  ConStrP4  = 'Jet OLEDB:Global Partial Bulk Ops=2;Jet OLEDB:Global Bulk Transactions=1;';
  ConStrP5  = 'Jet OLEDB:New Database Password="";Jet OLEDB:Create System Database=False;';
  ConStrP6  = 'Jet OLEDB:Encrypt Database=False;Jet OLEDB:Don''''t Copy Locale on Compact=False;';
  ConStrP7  = 'Jet OLEDB:Compact Without Replica Repair=False;Jet OLEDB:SFP=False';

implementation


end.
