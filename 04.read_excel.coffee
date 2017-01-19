# Read Excel file
excel = require('xlsx')
workbook = excel.readFile('data.xlsx')
data =  excel.utils.sheet_to_json workbook.Sheets[workbook.SheetNames[0]]


get_date_string =  ->
    d = new Date()
    d.getFullYear() + ("0" + (d.getMonth() + 1)).slice(-2) +  ("0" + d.getDate()).slice(-2) +
                  ("0" + d.getHours()).slice(-2) +  ("0" + d.getMinutes()).slice(-2) + ("0" + d.getSeconds()).slice(-2)


data.forEach (row) ->
    console.log row.email
    console.log row.title
    console.log row.first_name
    console.log row.last_name
    console.log row.password
    console.log row.birth_date
    console.log row.birth_month
    console.log row.birth_year
    console.log row.newsletter
    console.log row.receive_offers
    console.log row.address
    console.log row.city
    console.log row.state
    console.log row.zip
    console.log row.country
    console.log row.mobile
    console.log row.address_alias
    console.log "====================================="
