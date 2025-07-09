# 📦 rtfCreator

> A macro that allows you to easily create RTF files from your dataset
![スクリーンショット 2025-07-09 151558](https://github.com/user-attachments/assets/ce8b2b07-a7d8-4038-b3c3-57b3f1bec948)

---

## 🔍 Overview

**`rtfCreator`** is a simple SAS macro that enables you to generate RTF tables by specifying:

- Dataset name  
- Number of columns  
- Variable names  
- Column justifications (Left / Right / Center)  
- Column widths  

Optionally, you can apply your own STYLE template or add extra formatting like headers, footers, page breaks, and bottom borders.

---

## 🧾 Parameters

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

## 🚀 How to Use

### 📌 Example A — Simple Table
```sas
%rtfcreator(
  DS       = sashelp.class,
  COLNUM   = 2,
  VARLST   = name sex,
  JUSTLST  = Left Center,
  WIDTHLST = 300 150
);
