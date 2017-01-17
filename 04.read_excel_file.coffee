excel = require('xlsx');
workbook = excel.readFile('data.xlsx');
console.log "All sheet names:"
console.log n for n in workbook.SheetNames
console.log "------------------------------------------------------"
console.log excel.utils.sheet_to_json workbook.Sheets[workbook.SheetNames[0]]
