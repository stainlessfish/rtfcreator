# 📦 rtfCreator

> A macro that allows you to easily create RTF files from your dataset
![ChatGPT Image 2025年7月9日 14_56_09](https://github.com/user-attachments/assets/e584c57c-bce7-4b72-9880-dd38cea63c71)


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
| `DS`         | ✅       | Name of the input dataset                        |
| `COLNUM`     | ✅       | Number of columns                                |
| `VARLST`     | ✅       | List of variable names                           |
| `JUSTLST`    | ✅       | List of justifications (`Left`, `Right`, etc.)   |
| `WIDTHLST`   | ✅       | List of column widths                            |
| `OUTFILE`    | ❌       | Output file name                                 |
| `PAGEVAR`    | ❌       | Variable flag for page breaks                    |
| `LINEVAR`    | ❌       | Variable flag for bottom borders                 |
| `TBLHEAD`    | ❌       | Header text to appear at top of the table        |
| `TBLFOOT`    | ❌       | Footer text to appear at bottom of the table     |
| `STYLENAM`   | ❌       | RTF style template name                          |

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
