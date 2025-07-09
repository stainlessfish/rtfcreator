/*** HELP START ***//*

This is a macro that allows you to easily create RTF files.

You only need to specify the “dataset name,” “number of columns,” “variable names,” “left or right justyfy,” and “width.”
If you have your own STYLE template, you can also specify it.

Parameter: 
(Required)DS: Name of the dataset
(Required)COLNUM: Number of columns
(Required)VARLST: List of variable names
(Required)JUSTLST: List of justifications (e.g., left, right, center)
(Required)WIDTHLST: List of column widths
(Optional)OUTFILE: Output file name
(Optional)PAGEVAR: Page break flag variable
(Optional)LINEVAR: Bottom border flag variable
(Optional)TBLHEAD: Text of table top
(Optional)TBLFOOT: Foot of table bottom

** Example A  -- Simply;
**********************;
%rtfcreator(DS=sashelp.class
,COLNUM  =2
,VARLST  =name sex 
,JUSTLST =Left Center
,WIDTHLST=300 150 
);
** Example B -- use your STYLE template.;
**********************;
%rtfcreator(DS=sashelp.class
,COLNUM  =2
,VARLST  =name sex 
,JUSTLST =Left Center
,WIDTHLST=300 150 
,STYLENAM=Journal
);
** Example C -- Add text outside the table, bottom or top;
**********************;
%rtfCreator(DS=sashelp.class
,COLNUM  =2
,VARLST  =name sex 
,JUSTLST =Left Center
,WIDTHLST=300 150 
,TBLHEAD=%str(Table Head)
,TBLFOOT=%str(Table Foot)
);
** Example D -- Page break (you need to create a page break flag variable in advance, e.g., XXX = 1).;
**********************;
data RTFDS1;
  set sashelp.class;
  if _n_ eq 7 then PAGEBRK=1;
run;
%rtfcreator(DS=RTFDS1
,COLNUM  =2
,VARLST  =name sex 
,JUSTLST =Left Center
,WIDTHLST=300 150 
,PAGEVAR=PAGEBRK
);
** Example E -- adding a bottom border (you need to create a bottom border flag variable in advance, e.g., XXX = 1).;
**********************;
data RTFDS2;
  set sashelp.class;
  if _n_ eq 7 then BLINE=1;
run;
%rtfcreator(DS=RTFDS2
,COLNUM  =2
,VARLST  =name sex 
,JUSTLST =Left Center
,WIDTHLST=300 150 
,PAGEVAR=PAGEBRK
,LINEVAR=BLINE
);

*//*** HELP END ***/



%macro rtfCreator(
DS=
,COLNUM  =
,VARLST  =
,JUSTLST =
,WIDTHLST=
,HEAD_VJUST=top
,OUTFILE=
,PAGEVAR=DUMMY_PAGE
,LINEVAR=DUMMY_VAR
,STYLENAM=
,TBLHEAD=
,TBLFOOT=
);

%****************;
%**** Check argument;
%****************;
%if (0 =  %sysfunc(countw("&DS.")))   
 or (0 =  %sysfunc(countw("&COLNUM.")))  
 or (0 =  %sysfunc(countw("&VARLST.")))  
 or (0 =  %sysfunc(countw("&JUSTLST.")))  
 or (0 =  %sysfunc(countw("&WIDTHLST."))) %then %do; 
  %put ERROR:  The required argument is null.;
  %put ERROR:  &=COLNUM ;
  %put ERROR:  &=VARLST;
  %put ERROR:  &=JUSTLST ;
  %put ERROR:  &=WIDTHLST ;
  %put ERROR:  The rtfCreator macro has been terminated.;
  %abort;
%end;
%if ^(&COLNUM. eq %sysfunc(countw("&VARLST.")) and &COLNUM. eq %sysfunc(countw("&JUSTLST.")) and &COLNUM. eq %sysfunc(countw("&WIDTHLST."))) %then %do;
  %put ERROR: Argument-count mismatch detected. ;
  %put ERROR:  &=COLNUM ;
  %put ERROR:  &=VARLST;
  %put ERROR:  &=JUSTLST ;
  %put ERROR:  &=WIDTHLST ;
  %put ERROR:  The rtfCreator macro has been terminated.;
  %abort;
%end;



%****************;
%** setting;
%****************;

%** Output filename;
%if %length(&OUTFILE.)>0 %then %do;  %let _OUTFILE=%str(file="&OUTFILE."); %end;
%else                          %do;  %let _OUTFILE=; %end;

%** Use RTF Style;
%if %length(&STYLENAM.)>0 %then %do;  %let RTFSTYLE=&STYLENAM.; %end;
%else                           %do;  %let RTFSTYLE=STUDY_RTF;  %rtfdefine(); ods path (prepend) work.TEMPLAT(read); %end;


%****************;
%**** Create a macro variable from an argument;
%****************;
data _null_;

  do i=1 to &COLNUM.;
    put "---Column:" i "-----";
    %**** VAR LIST;
    tempVAR=scan("&VARLST.",i);
    call symputx(cats("VAR",i),tempVAR,"L");
    put "VARIABLE=" tempVAR;
    %**** Justyfy LIST;
    tempJST=scan("&JUSTLST.",i);
    call symputx(cats("JST",i),tempJST,"L");
    put "JUSTIFY=" tempJST;
    %**** width LIST;
    tempWID=scan("&WIDTHLST.",i);
    call symputx(cats("WID",i),tempWID,"L");
    put "WIDTH=" tempWID;
  end;
  stop;
run;
%put _LOCAL_;


%****************;
%****  output RTF file;
%****************;
ods rtf &_OUTFILE. style=&RTFSTYLE. notoc_data;

  proc odstable data=&DS.;
    column &VARLST. &PAGEVAR. &LINEVAR.;
    cellstyle &PAGEVAR. eq 1 as data{PRETEXT="(*ESC*)R'\pagebb' " }
             ,&LINEVAR. eq 1 as data{borderbottomwidth=1};
    define &PAGEVAR.;   print=no;end;
    define &LINEVAR.;   print=no;end;
    define header h0;  just=left; style={BorderBottomWidth=1 BorderTopStyle=hidden}; text "&TBLHEAD.";  end;
    %do i=1 %to &COLNUM.;
      define header h&i.;         start=&&VAR&i..; end=&&VAR&i..; vjust=&HEAD_VJUST.; just=&&JST&i.;                                                  end;
      define column &&VAR&i..;                                                        just=&&JST&i.;    style={cellwidth=&&WID&i};  blank_dups=off;   end;
    %end;
    define footer f1;  just=left; style={BorderBottomStyle=hidden}; text "&TBLFOOT.";  end;
  run;

ods rtf close;

%mend rtfCreator;
