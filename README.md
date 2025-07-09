#  rtfCreator

> A macro that allows you to easily create RTF files from your dataset


![image](https://github.com/user-attachments/assets/ca68686e-e308-4dad-8a9e-ec6f40b38961)

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

### Example A  -- Simply Table;
```sas
%rtfcreator(DS=sashelp.class
,COLNUM  =2
,VARLST  =name sex 
,JUSTLST =Left Center
,WIDTHLST=300 150 
);
```

![image](https://github.com/user-attachments/assets/21a3b247-fd26-47f5-8509-30690e746fa7)

---

### Example B -- use your STYLE template. (e.g. Journal);
```sas
%rtfcreator(DS=sashelp.class
,COLNUM  =2
,VARLST  =name sex 
,JUSTLST =Left Center
,WIDTHLST=300 150 
,STYLENAM=Journal
);
```

![image](https://github.com/user-attachments/assets/05ae8971-0e57-4aed-ac10-0811ad101ce1)

---

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

![image](https://github.com/user-attachments/assets/ed41b190-2cbf-4c86-9aba-0436babd314a)

---

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

![image](https://github.com/user-attachments/assets/5da9b138-0105-4d3d-b9e7-64feff4227dc)

---

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
,LINEVAR=BLINE
);
```
![image](https://github.com/user-attachments/assets/8788d913-60b4-499a-907e-9352d1076666)



# What is SAS Packages?
The package is built on top of **SAS Packages framework(SPF)** created by Bartosz Jablonski.<br>
For more on SAS Packages framework, see [SASPAC](https://github.com/yabwon/SAS_PACKAGES).<br>
You can also find more SAS Packages(SASPAC) in [GitHub](https://github.com/SASPAC)<br>


# How to use SASPACer? (quick start)
Create directory for your packages and assign a fileref to it.
~~~sas      
filename packages "\path\to\your\packages";
~~~
Enable the SAS Packages Framework (if you have not done it yet):

~~~sas      
%include packages(SPFinit.sas)
~~~
(If you don't have SAS Packages Framework installed follow the instruction.)

When you have SAS Packages Framework enabled, run the following to install and load the package:


~~~sas      
/* Install and load SASPACer */
%installPackage(SASPACer, sourcePath=https://github.com/Nakaya-Ryo/SASPACer/raw/main/)   /* Install SASPACer to your place */
%loadPackage(SASPACer)
/* Enjoy SASPACer😄 */
%ex2pac(
  excel_file=C:\Temp\simple_example.xlsx,
  package_location=C:\Temp\SAS_PACKAGES\packages,
  complete_generation=Y
)
~~~
You can learn from the following training materials by Bartosz Jablonski for source files and folders structure of SAS packages.<br>
[My first SAS Package -a How To](https://github.com/yabwon/SAS_PACKAGES/blob/main/SPF/Documentation/SAS(r)%20packages%20-%20the%20way%20to%20share%20(a%20how%20to)-%20Paper%204725-2020%20-%20extended.pdf).<br>
[SAS Packages - The Way To Share (a How To)](https://github.com/yabwon/SAS_PACKAGES/blob/main/SPF/Documentation/SAS(r)%20packages%20-%20the%20way%20to%20share%20(a%20how%20to)-%20Paper%204725-2020%20-%20extended.pdf)

