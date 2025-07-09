#  rtfCreator

> A macro that allows you to easily create RTF files from your dataset
![スクリーンショット 2025-07-09 151558](https://github.com/user-attachments/assets/ce8b2b07-a7d8-4038-b3c3-57b3f1bec948)

---

##  Overview

**`rtfCreator`** is a simple SAS macro that enables you to generate RTF tables by specifying:

- Dataset name  
- Number of columns  
- Variable names  
- Column justifications (Left / Right / Center)  
- Column widths  

Optionally, you can apply your own STYLE template or add extra formatting like headers, footers, page breaks, and bottom borders.

---


##  Version history
0.1.0(9July2025) : Initial version
---

##  Parameters

| Parameter    | Required | Description                                      |
|--------------|----------|--------------------------------------------------|
| `DS`         |  Y      | Name of the input dataset                        |
| `COLNUM`     |  Y      | Number of columns                                |
| `VARLST`     |  Y      | List of variable names                           |
| `JUSTLST`    |  Y      | List of justifications (`Left`, `Right`, etc.)   |
| `WIDTHLST`   |  Y      | List of column widths                            |
| `OUTFILE`    |  N      | Output file name                                 |
| `PAGEVAR`    |  N      | Variable flag for page breaks                    |
| `LINEVAR`    |  N      | Variable flag for bottom borders                 |
| `TBLHEAD`    |  N      | Header text to appear at top of the table        |
| `TBLFOOT`    |  N      | Footer text to appear at bottom of the table     |
| `STYLENAM`   |  N      | RTF style template name                          |

---

##  How to Use

###  Example A — Simple Table
```sas
%rtfcreator(
  DS       = sashelp.class,
  COLNUM   = 2,
  VARLST   = name sex,
  JUSTLST  = Left Center,
  WIDTHLST = 300 150
);
```

### Example A  -- Simply;
```sas
%rtfcreator(DS=sashelp.class
,COLNUM  =2
,VARLST  =name sex 
,JUSTLST =Left Center
,WIDTHLST=300 150 
);
```

### Example B -- use your STYLE template.;
```sas
%rtfcreator(DS=sashelp.class
,COLNUM  =2
,VARLST  =name sex 
,JUSTLST =Left Center
,WIDTHLST=300 150 
,STYLENAM=Journal
);
```

### Example C -- Add text outside the table, bottom or top;
```sas
%rtfCreator(DS=sashelp.class
,COLNUM  =2
,VARLST  =name sex 
,JUSTLST =Left Center
,WIDTHLST=300 150 
,TBLHEAD=%str(Table Head)
,TBLFOOT=%str(Table Foot)
);
```

### Example D -- Page break (you need to create a page break flag variable in advance, e.g., XXX = 1).;
```sas
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
```

### Example E -- adding a bottom border (you need to create a bottom border flag variable in advance, e.g., XXX = 1).;
```sas
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
```

## What is SAS Packages?
OncoPlotter is built on top of SAS Packages framework(SPF) developed by Bartosz Jablonski.
For more information about SAS Packages framework, see SAS_PACKAGES.
You can also find more SAS Packages(SASPACs) in SASPAC.
---
