page 50400 SecuredPage
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;


    trigger OnOpenPage()
    var
        fingerprint: Codeunit "Fingerprint";
    begin
        if not fingerprint.GetConsent('Open very secure page') then
            ERROR('You must give consent to open this page');
    end;
}