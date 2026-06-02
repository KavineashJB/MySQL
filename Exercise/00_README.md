### Not completed List:

10. Netflix - continous tamil content consumer - how to find the user who didn't watch other lang movies only tamil for consecutive months

11. Zomato - festival food order - What are all the major festivals and how to find it

# NOTE

In the `Exercise` folder, some queries may ask for records from the **last 2 months** (or recent dates).  
In such cases, the inserted record dates in your files may not match the expected result.

Instead of manually changing dates one by one, you can quickly update all dates at once using **Global Search and Replace** in VS Code.

---

# GLOBAL SEARCH AND REPLACE IN ALL FILES USING VS CODE

## 1. Open Visual Studio Code

---

## 2. Open Your Project Folder

```text
File → Open Folder → Select Folder
```

---

## 3. Open Global Search and Replace

### Windows/Linux

```text
Ctrl + Shift + H
```

### Mac

```text
Cmd + Shift + H
```

---

## 4. Search Text

In the **Search** box, type the word/text/date you want to find.

---

## 5. Replace Text

In the **Replace** box, type the new word/text/date.

---

## 6. Useful VS Code Symbols

| Symbol | Purpose                         |
| ------ | ------------------------------- |
| `.*`   | Use Regular Expression (RegExp) |
| `Aa`   | Match Case                      |
| `ab`   | Match Whole Word                |
| `✕`    | Dismiss / Clear Search          |
| `↺ab`  | Replace                         |
| `↺ac`  | Replace All                     |

---

## 7. OPTIONAL — Exclude Files/Folders

Use the **files to exclude** box.

### Examples

### Single File

```text
database.sql
```

### Multiple Files

```text
database.sql,config.js,test.txt
```

### Single Folder

```text
node_modules/**
```

### Specific Folder

```text
src/database/**
```

### Multiple Folders

```text
node_modules/**,build/**
```

### Exclude by Extension

```text
*.sql
```

### Multiple Extensions

```text
*.log,*.tmp,*.class
```

---

## 8. Search All Files

Press:

```text
Enter
```

---

## 9. Review Search Results

Carefully review all matched files before replacing.

---

## 10. Replace Only in Selected Files

- Hold `CTRL` (Windows/Linux) or `CMD` (Mac)
  to select multiple individual files

- Hold `SHIFT`
  to select a range of files

- Select only the wanted files
  OR
  select unwanted files and skip them

---

## 11. Replace Selected Files

After selecting files:

- Hover over the selected file(s)
- Click the small Replace icon beside the file

OR

- Open the file and replace manually

---

## 12. IMPORTANT

Do **NOT** click:

```text
↺ac (Replace All)
```

if you want to skip some files.

---

## 13. Save All Files

### Windows/Linux

```text
Ctrl + Shift + S
```

### Mac

```text
Cmd + Option + S
```

---

# DONE

VS Code will replace the specified text only in the selected files while excluded/skipped files remain unchanged.

---

> **IMPORTANT:**  
> Even after using `↺ac (Replace All)` across the whole project, you can usually undo the changes using:
>
> - `Ctrl + Z` (Windows/Linux)
> - `Cmd + Z` (Mac)
>
> Undo works best before closing VS Code or making many additional edits.
