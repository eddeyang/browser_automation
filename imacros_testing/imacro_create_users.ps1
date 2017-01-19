$data = Import-Excel C:\temp\data.xlsx;

Remove-Item -Path "C:\Users\eyang\Documents\iMacros\Downloads\done" -Force -ErrorAction SilentlyContinue;

foreach($row in $data)
{
    $email = (Get-Date -Format "yyyyMMddhhmmssmsms") + $row.email;
    $script = @"
URL GOTO=http://automationpractice.com/index.php?controller=authentication&back=my-account
WAIT SECONDS=2
TAG POS=1 TYPE=INPUT:TEXT FORM=ID:create-account_form ATTR=ID:email_create CONTENT=$email
TAG POS=1 TYPE=BUTTON FORM=ID:create-account_form ATTR=ID:SubmitCreate
WAIT SECONDS=2
TAG POS=1 TYPE=INPUT:RADIO FORM=ID:account-creation_form ATTR=ID:id_gender$(if($row.title -eq "Mr."){"1"}else{"2"})
TAG POS=1 TYPE=INPUT:TEXT FORM=ID:account-creation_form ATTR=ID:customer_firstname CONTENT=$($row.first_name)
TAG POS=1 TYPE=INPUT:TEXT FORM=ID:account-creation_form ATTR=ID:customer_lastname CONTENT=$($row.last_name)
SET !ENCRYPTION NO
TAG POS=1 TYPE=INPUT:PASSWORD FORM=ID:account-creation_form ATTR=ID:passwd CONTENT=$($row.password)
TAG POS=1 TYPE=SELECT FORM=ID:account-creation_form ATTR=ID:days CONTENT=%$($row.birth_date)
TAG POS=1 TYPE=SELECT FORM=ID:account-creation_form ATTR=ID:months CONTENT=`$$($row.birth_month)
TAG POS=1 TYPE=SELECT FORM=ID:account-creation_form ATTR=ID:years CONTENT=%$($row.birth_year)
$(if($row.newsletter -eq "y")
{
"TAG POS=1 TYPE=LABEL FORM=ID:account-creation_form ATTR=TXT:Sign<SP>up<SP>for<SP>our<SP>newsletter!"
})
$(
if($row.receive_offers -eq "y")
{
"TAG POS=1 TYPE=LABEL FORM=ID:account-creation_form ATTR=TXT:Receive<SP>special<SP>offers<SP>from<SP>our<SP>partners!"
})
TAG POS=1 TYPE=INPUT:TEXT FORM=ID:account-creation_form ATTR=ID:firstname CONTENT=$($row.first_name)
TAG POS=1 TYPE=INPUT:TEXT FORM=ID:account-creation_form ATTR=ID:lastname CONTENT=$($row.last_name)
TAG POS=1 TYPE=INPUT:TEXT FORM=ID:account-creation_form ATTR=ID:address1 CONTENT=$($row.address -replace " ", "<SP>")
TAG POS=1 TYPE=SELECT FORM=ID:account-creation_form ATTR=ID:id_country CONTENT=`$$($row.country -replace " ", "<SP>")
WAIT SECONDS=2
TAG POS=1 TYPE=INPUT:TEXT FORM=ID:account-creation_form ATTR=ID:city CONTENT=$($row.city)
TAG POS=1 TYPE=SELECT FORM=ID:account-creation_form ATTR=ID:id_state CONTENT=`$$($row.state -replace " ", "<SP>")
TAG POS=1 TYPE=INPUT:TEXT FORM=ID:account-creation_form ATTR=ID:postcode CONTENT=$($row.zip)
TAG POS=1 TYPE=INPUT:TEXT FORM=ID:account-creation_form ATTR=ID:phone_mobile CONTENT=$($row.mobile)
TAG POS=1 TYPE=INPUT:TEXT FORM=ID:account-creation_form ATTR=ID:alias CONTENT=$($row.address_alias -replace " ", "<SP>")
TAG POS=1 TYPE=BUTTON FORM=ID:account-creation_form ATTR=ID:submitAccount
WAIT SECONDS=2
TAG POS=1 TYPE=A ATTR=TXT:Sign<SP>out
SAVEAS TYPE=EXTRACT FOLDER=* FILE=done
"@
    $script | Out-File "C:\Users\eyang\Documents\iMacros\Macros\$("create_user_" + $row.first_name + ".iim")" -Force;

    Start-Process -FilePath "C:\Program Files\Mozilla Firefox\firefox.exe" -ArgumentList "imacros://run/?m=$("create_user_" + $row.first_name + ".iim")"
    while(!(Test-Path -Path "C:\Users\eyang\Documents\iMacros\Downloads\done" -PathType Leaf))
    {
        Start-Sleep 1;
    }
    Remove-Item -Path "C:\Users\eyang\Documents\iMacros\Downloads\done" -Force -ErrorAction SilentlyContinue;
}