N = require "nightmare"
n = N(
    show: true
    timeout: 10000
)

get_date_string =  ->
    d = new Date()
    d.getFullYear() + ("0" + (d.getMonth() + 1)).slice(-2) +  ("0" + d.getDate()).slice(-2) +
                  ("0" + d.getHours()).slice(-2) +  ("0" + d.getMinutes()).slice(-2) + ("0" + d.getSeconds()).slice(-2)

n.viewport 1000, 700
 .goto "http://automationpractice.com/index.php?controller=my-account"
 .type "#email_create", "edde#{get_date_string()}@outlook.com"
 .click "#SubmitCreate"
 .wait "#id_gender1"
 .click "#id_gender1"
 .type "#customer_firstname", "FirstName"
 .type "#customer_lastname", "LastName"
 .type "#passwd", "password123"
 .select "#days", "9"
 .select "#months", "10"
 .select "#years", "1982"
 .check "#newsletter"
 .check "#optin"
 .insert "#firstname", false
 .insert "#firstname", "FirstName"
 .insert "#lastname", false
 .insert "#lastname", "LastName"
 .type "#company", "The Free Software Foundation"
 .type "#address1", "51 Franklin Stree"
 .type "#address2", "building #2"
 .select "#id_country", "21"
 .wait 1000
 .select "#id_state", "21"
 .type "#city", "Boston"
 .type "#postcode", "11112"
 .type "#phone", "82332832832832"
 .type "#phone_mobile", "2332232332"
 .type "#alias", false
 .type "#alias", "myalias"
 .click "#submitAccount"
 .wait "a.logout"
 .click "a.logout"
 .wait 5000
 .end()
 .then(->
     console.log "Done"
 )
 .catch (e) ->
     console.error e
